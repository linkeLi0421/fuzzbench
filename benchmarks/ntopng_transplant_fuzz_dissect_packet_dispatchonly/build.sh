#!/bin/bash -eu
# Generated for bug transplant evaluation of ntopng fuzz_dissect_packet.

cd /src/ntopng

# Checkout target commit
git checkout b7b2810e617117c4420a5e1a4639515f2c45b26b

# Restore harness sources that live outside the project git repository.
if [ -f /src/patches/harness_sources/manifest.json ]; then
    python3 - <<'PY'
import json
import shutil
from pathlib import Path

root = Path("/src/patches/harness_sources")
for entry in json.loads((root / "manifest.json").read_text()):
    source = root / entry["snapshot"]
    destination = Path(entry["container_path"])
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, destination)
PY
fi

# Apply dispatch harness first (adds __bug_dispatch.{c,h} + harness edits),
# then the combined bug-trigger patches.
if ! git apply --check /src/patches/harness.diff 2>/dev/null; then
    echo "Trying git apply --3way for harness.diff..."
    git apply --3way /src/patches/harness.diff
else
    git apply /src/patches/harness.diff
fi

# [dispatch-only variant] combined.diff intentionally NOT applied (no bug patches)

# ntopng leaks ~33KB in HostPools::HostPools() at process start. FuzzBench's
# coverage measurer forces ASAN_OPTIONS=detect_leaks=1, which overrides the
# container env var and makes every snapshot exit non-zero. Inject a binary-
# wide __lsan_default_options into the harness so snapshots stay clean.
python3 - <<'PY'
from pathlib import Path
p = Path("/src/ntopng/fuzz/fuzz_dissect_packet.cpp")
text = p.read_text()
if "__lsan_default_options" not in text:
    marker = '#include "__bug_dispatch.h"\n'
    override = (
        '#include <stdlib.h>\n\n'
        'extern "C" const char *__lsan_default_options(void) {\n'
        '    /* ntopng leaks ~33KB in HostPools init; disable LSAN binary-wide so the\n'
        '     * FuzzBench coverage measurer doesn\'t exit non-zero on every snapshot. */\n'
        '    return "detect_leaks=0";\n'
        '}\n\n'
    )
    text = text.replace(marker, marker + override, 1)
    p.write_text(text)
PY

# --- Original build commands (adapted from ntopng OSS-Fuzz build.sh) ---

# Build static-linked deps with instrumentation disabled — matches the
# OSS-Fuzz ntopng recipe so coverage maps don't get dominated by libpcap /
# zeromq / json-c / maxminddb edges.
CFLAGS_SAVE="$CFLAGS"
CXXFLAGS_SAVE="$CXXFLAGS"
unset CFLAGS
unset CXXFLAGS
export AFL_NOOPT=1
# oss-fuzz's base builder passes -stdlib=libc++ by default.
export CXXFLAGS="-stdlib=libc++"

# libpcap
cd /src
tar -xzf /src/libpcap-1.9.1.tar.gz
cd /src/libpcap-1.9.1
# Disable optional backends so libpcap.a doesn't pick up dbus/bluetooth/rdma
# symbols from transitively-installed -dev packages. Without this, ntopng's
# `./configure --enable-fuzztargets` link-test for pcap_open_live silently
# fails under aflplusplus / libafl, leaving no fuzz/Makefile and no binary.
# Honor $CC/$CXX so libpcap gets the same instrumentation as ntopng.
./configure --disable-shared \
    --disable-dbus --disable-bluetooth --disable-rdma \
    --without-libnl --without-dpdk --without-dag --without-septel --without-snf \
    CC="$CC" CXX="$CXX"
make -j$(nproc) -k CC="$CC" CXX="$CXX" 2>&1 || true
make install

# zeromq
cd /src
tar -xzf /src/zeromq-4.3.4.tar.gz
cd /src/zeromq-4.3.4
./autogen.sh
./configure --without-documentation --without-libsodium --enable-static --disable-shared
make -j$(nproc) -k 2>&1 || true
make install

# json-c (GitHub archive tarball extracts as json-c-json-c-<tag>)
cd /src
tar -xzf /src/json-c-0.16-20220414.tar.gz
cd /src/json-c-json-c-0.16-20220414
mkdir -p build
cd build
cmake -DBUILD_SHARED_LIBS=OFF ..
make -j$(nproc) -k 2>&1 || true
make install

# libmaxminddb
cd /src
tar -xzf /src/libmaxminddb-1.7.1.tar.gz
cd /src/libmaxminddb-1.7.1
./configure --disable-shared --enable-static
make -j$(nproc) -k 2>&1 || true
make install

### ntopng dependencies ###

# Build nDPI (in-tree, not installed)
cd $NDPI_HOME
./autogen.sh
./configure
make -j$(nproc) -k 2>&1 || true

# Build bundled LUA
make -C $NTOPNG_HOME/third-party/lua-5.4.3 generic

# Build bundled librrdtool
cd $NTOPNG_HOME/third-party/rrdtool-1.4.8
./configure --disable-libdbi --disable-libwrap --disable-rrdcgi --disable-libtool-lock \
    --disable-nls --disable-rpath --disable-perl --disable-ruby --disable-lua \
    --disable-tcl --disable-python --disable-dependency-tracking --disable-rrd_graph
cd src
make librrd_th.la


# Re-enable code instrumentation
export CFLAGS="${CFLAGS_SAVE}"
export CXXFLAGS="${CXXFLAGS_SAVE}"
unset AFL_NOOPT

### Build ntopng ###

cd $NTOPNG_HOME

./autogen.sh

./configure --enable-fuzztargets --without-hiredis --with-zmq-static \
    --with-json-c-static --with-maxminddb-static \
    CC="$CC" CXX="$CXX"

# >>> bug_transplant: compile and link __bug_dispatch <<<
# Use $CC (not hardcoded `clang`) so libafl's afl_cc wrapper flags like
# `--libafl` are honored, and aflplusplus's afl-clang-fast instruments this
# object the same way as the rest of the binary.
if [ -f __bug_dispatch.c ]; then
  $CC $CFLAGS -c __bug_dispatch.c -o __bug_dispatch.o
  grep -q '__bug_dispatch.o' fuzz/Makefile || sed -i '/^fuzz\/fuzz_dissect_packet:/ s| *$| __bug_dispatch.o|' fuzz/Makefile
fi
# <<< bug_transplant: compile and link __bug_dispatch >>>

make -j$(nproc) -k CC="$CC" CXX="$CXX" fuzz_all 2>&1 || true

# Copy fuzzers
find fuzz/ -regex 'fuzz/fuzz_[a-z_]*\(\.\(zip\|dict\|options\)\)?' -exec cp {} $OUT/ \;

# Create the directory structure needed for fuzzing
mkdir -p $OUT/install $OUT/data-dir $OUT/docs $OUT/scripts/callbacks


# --- Seed corpus: expand original seeds and per-bug testcase candidates ---
# FuzzBench uses $OUT/{fuzz_target}_seed_corpus.zip as initial corpus.
# Prepend each possible 1-byte dispatch value to the original seeds so the
# harness accepts them. Per-bug PoCs are only kept as non-crashing variants
# (exact crashing inputs are filtered out during packaging).
seed_zip="$OUT/fuzz_dissect_packet_seed_corpus.zip"
seed_target="$OUT/fuzz_dissect_packet"
mkdir -p /tmp/seeds_dispatch /tmp/original_seeds /tmp/benchmark_seed_candidates

if [ -f "$seed_zip" ]; then
    unzip -q -o "$seed_zip" -d /tmp/original_seeds 2>/dev/null || true
    for f in /tmp/original_seeds/*; do
        [ -f "$f" ] || continue
        base=$(basename "$f")
        for dispatch in '\x00' '\x01' '\x02' '\x04' '\x08' '\x10' '\x20' '\x40' '\x80'; do
            dispatch_name=$(printf '%s' "$dispatch" | tr -d '\x')
            printf '%b' "$dispatch" | cat - "$f" > "/tmp/seeds_dispatch/${base}.dispatch_${dispatch_name}"
        done
    done
fi

if [ -d /src/benchmark_seeds ]; then
    for f in /src/benchmark_seeds/*; do
        [ -f "$f" ] || continue
        base=$(basename "$f")
        size=$(wc -c < "$f")
        [ "$size" -gt 0 ] || continue

        cp "$f" "/tmp/benchmark_seed_candidates/${base}.exact"
        # Zero the dispatch byte (byte 0): deactivates dispatch-gated patches
        # while keeping the full pcap conversation intact.
        cp "$f" "/tmp/benchmark_seed_candidates/${base}.dispatch_zero"
        printf '\000' | dd of="/tmp/benchmark_seed_candidates/${base}.dispatch_zero" bs=1 seek=0 conv=notrunc 2>/dev/null || true
        for keep in 1 2 8 16 64 256 1024; do
            if [ "$size" -gt "$keep" ]; then
                head -c "$keep" "$f" > "/tmp/benchmark_seed_candidates/${base}.head_${keep}"
            fi
        done
        if [ "$size" -gt 1 ]; then
            head -c "$((size - 1))" "$f" > "/tmp/benchmark_seed_candidates/${base}.trim_1"
            cp "$f" "/tmp/benchmark_seed_candidates/${base}.zero_last"
            printf '\000' | dd of="/tmp/benchmark_seed_candidates/${base}.zero_last" bs=1 seek="$((size - 1))" conv=notrunc 2>/dev/null || true
            cp "$f" "/tmp/benchmark_seed_candidates/${base}.ff_last"
            printf '\377' | dd of="/tmp/benchmark_seed_candidates/${base}.ff_last" bs=1 seek="$((size - 1))" conv=notrunc 2>/dev/null || true
        fi
        if [ "$size" -gt 4 ]; then
            mid=$((size / 2))
            cp "$f" "/tmp/benchmark_seed_candidates/${base}.zero_mid"
            printf '\000' | dd of="/tmp/benchmark_seed_candidates/${base}.zero_mid" bs=1 seek="$mid" conv=notrunc 2>/dev/null || true
            cp "$f" "/tmp/benchmark_seed_candidates/${base}.ff_mid"
            printf '\377' | dd of="/tmp/benchmark_seed_candidates/${base}.ff_mid" bs=1 seek="$mid" conv=notrunc 2>/dev/null || true
        fi
    done
fi

if [ -x "$seed_target" ] && ls /tmp/benchmark_seed_candidates/* 1>/dev/null 2>&1; then
    for f in /tmp/benchmark_seed_candidates/*; do
        [ -f "$f" ] || continue
        # Drop seeds too small to contain a pcap global header (24 bytes).
        fsize=$(wc -c < "$f")
        if [ "$fsize" -lt 25 ]; then
            continue
        fi
        if timeout 10s env ASAN_OPTIONS="${ASAN_OPTIONS:-detect_leaks=0:detect_stack_use_after_return=1}" "$seed_target" "$f" >/tmp/seed_replay.log 2>&1; then
            cp "$f" "/tmp/seeds_dispatch/poc_$(basename "$f")"
        fi
    done
fi

# NOTE: do not use `ls /tmp/seeds_dispatch/*` here. With a large corpus the
# glob exceeds ARG_MAX (ndpi_reader: 35k seeds ~= 2.06MB > 2MB limit), the
# test silently fails, the seed zip is never written, and FuzzBench starts
# the fuzzers from a 2-byte fake seed. `find -quit` has no such limit.
if [ -n "$(find /tmp/seeds_dispatch -maxdepth 1 -type f -print -quit 2>/dev/null)" ]; then
    rm -f "$seed_zip"
    zip -j -q "$seed_zip" /tmp/seeds_dispatch/*
fi
