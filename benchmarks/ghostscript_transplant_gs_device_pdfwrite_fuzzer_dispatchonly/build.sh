#!/bin/bash -eu
# Generated from the offline bug-transplant merge (ghostscript e088d3a8).
# Checks out the target ghostpdl commit, applies the dispatch patches, then
# builds the single gs_device_pdfwrite_fuzzer FuzzBench cares about.

# ---------------------------------------------------------------------------
# 1. Build CUPS (required by ghostscript's --enable-cups link).
# ---------------------------------------------------------------------------
pushd /src/cups
# Fix a long-standing bad cast in ppd-cache.c that trips modern clang.
sed -i '2110s/\(\s\)f->value/\1(int)f->value/' cups/ppd-cache.c

# CUPS branch-2.2 uses strlcpy without declaring it, which is -Werror with
# honggfuzz/libafl compilers. Relax the check for this old code.
export CFLAGS="${CFLAGS:-} -Wno-error=implicit-function-declaration"
export CXXFLAGS="${CXXFLAGS:-} -Wno-error=implicit-function-declaration"

LSB_BUILD=y ./configure --prefix="$WORK" --libdir="$OUT" --disable-gnutls \
   --disable-libusb --with-components=core

make clean
make -C filter clean 2>/dev/null || true
make install-headers install-libs
make -C filter libs install-libs
install -m755 cups-config "$WORK"/cups-config
popd

# ---------------------------------------------------------------------------
# 2. Check out the target ghostpdl commit and apply the transplant patches.
# ---------------------------------------------------------------------------
cd /src/ghostpdl
git checkout -f e088d3a844717878592fa5ccf871729983140676

# Ghostscript expects freetype in-tree; replace the vendored copy with the
# pinned VER-2-12-1 clone that was fetched in the Dockerfile. Leave the other
# vendored libraries (libpng, tiff, zlib, jpeg) in place — the original
# merge environment kept them and mixing them with system-wide shared libs
# (e.g. libjpeg-dev) trips ghostpdl's "Mixing local libtiff with shared
# libjpeg not supported" configure check.
rm -rf freetype
cp -a /src/freetype freetype

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

# Apply dispatch harness first (adds __bug_dispatch.[ch] at the ghostpdl root),
# then the combined per-bug patches.
if ! git apply --check /src/patches/harness.diff 2>/dev/null; then
    echo "Trying git apply --3way for harness.diff..."
    git apply --3way /src/patches/harness.diff
else
    git apply /src/patches/harness.diff
fi

# [dispatch-only variant] combined.diff intentionally NOT applied (no bug patches)

# ---------------------------------------------------------------------------
# 3. Configure & build libgs.
# ---------------------------------------------------------------------------
CUPSCONFIG="$WORK/cups-config"
CUPS_CFLAGS=$($CUPSCONFIG --cflags)
CUPS_LDFLAGS=$($CUPSCONFIG --ldflags)
CUPS_LIBS=$($CUPSCONFIG --image --libs)
export CXXFLAGS="$CXXFLAGS $CUPS_CFLAGS"

# --disable-fontconfig: FuzzBench runner images are slim and do not ship
# libfontconfig.so.1, which would make the fuzzer fail to start. Font
# discovery isn't needed for the transplanted bug crashes.
CPPFLAGS="${CPPFLAGS:-} $CUPS_CFLAGS -DPACIFY_VALGRIND" ./autogen.sh \
  CUPSCONFIG=$CUPSCONFIG \
  --enable-freetype --disable-fontconfig \
  --enable-cups --with-ijs --with-jbig2dec \
  --with-drivers=pdfwrite,cups,ljet4,laserjet,pxlmono,pxlcolor,pcl3,uniprint,pgmraw,ps2write,png16m,tiffsep1,faxg3,psdcmyk,eps2write,bmpmono,xpswrite

# ghostpdl's autogen.sh auto-adds `-fno-sanitize-recover=...,shift,signed-integer-overflow,...`
# when UBSAN is detected. That makes pre-existing shift UB in base/gsiorom.c
# abort the binary on every run, masking the real bug crashes we need to
# locate. Strip that flag.
find . -name Makefile -exec sed -i 's/-fno-sanitize-recover=[^ ]*//g' {} +

# autogen also injects a per-check UBSAN list into every Makefile compile
# rule (-fsanitize=array-bounds,bool,builtin,...,vptr -- NOT the umbrella
# -fsanitize=undefined form). Every transplanted bug here is an ASAN
# heap/stack/UAF error, so strip it: it only adds recoverable "runtime
# error:" noise, and under afl++ (ASAN_OPTIONS=abort_on_error=1) it turns
# each report into SIGABRT and kills seeds during calibration. The leading
# `-fsanitize=address` stays. Mirrors gstoraster's build.sh.
find . -name Makefile -exec sed -i 's/-fsanitize=array-bounds[^ ]*//g' {} +
# Safety net for the umbrella form in case any future check uses it.
find . -name Makefile -exec sed -i 's/-fsanitize=undefined//g' {} +

make -j$(nproc) libgs

# ---------------------------------------------------------------------------
# 4. Link gs_device_pdfwrite_fuzzer with the dispatch-aware harness.
# ---------------------------------------------------------------------------
BUG_DISPATCH_OBJ="$WORK/__bug_dispatch.o"
$CC $CFLAGS -I. -I$SRC -I$SRC/ghostpdl -c "$SRC/ghostpdl/__bug_dispatch.c" -o "$BUG_DISPATCH_OBJ"

$CXX $CXXFLAGS $CUPS_LDFLAGS -std=c++11 -I. -I$SRC -I$SRC/ghostpdl \
    $SRC/gs_device_pdfwrite_fuzzer.cc \
    "$BUG_DISPATCH_OBJ" \
    -o "$OUT/gs_device_pdfwrite_fuzzer" \
    -Wl,-rpath='$ORIGIN' \
    $CUPS_LIBS \
    $LIB_FUZZING_ENGINE bin/gs.a

# ---------------------------------------------------------------------------
# 5. Base seed corpus (pdf_seeds + a sample of ghostpdl's example files).
# ---------------------------------------------------------------------------
mkdir -p "$WORK/seeds"
cp /src/pdf_seeds/*.pdf "$WORK/seeds/" 2>/dev/null || true
for f in examples/*.pdf examples/*.ps; do
    [ -f "$f" ] || continue
    s=$(sha1sum "$f" | awk '{print $1}')
    cp "$f" "$WORK/seeds/$s"
done

zip -j "$OUT/gs_device_pdfwrite_fuzzer_seed_corpus.zip" "$WORK"/seeds/*

# Dictionary file (pdf keywords) helps mutation-based fuzzers.
cp /src/dicts/pdf.dict "$OUT/gs_device_pdfwrite_fuzzer.dict"

# ---------------------------------------------------------------------------
# 6. Expand the seed corpus with dispatch-prefix variants and add any
#    non-crashing per-bug testcase candidates. Mirrors the logic used by the
#    other transplant benchmarks so FuzzBench fuzzers see inputs across all
#    dispatch bits.
# ---------------------------------------------------------------------------
seed_zip="$OUT/gs_device_pdfwrite_fuzzer_seed_corpus.zip"
seed_target="$OUT/gs_device_pdfwrite_fuzzer"
mkdir -p /tmp/seeds_dispatch /tmp/original_seeds /tmp/benchmark_seed_candidates

if [ -f "$seed_zip" ]; then
    unzip -q -o "$seed_zip" -d /tmp/original_seeds 2>/dev/null || true
    for f in /tmp/original_seeds/*; do
        [ -f "$f" ] || continue
        base=$(basename "$f")
        for dispatch in 00 01 02 04 08 10 20 40 80; do
            printf '%b' "\\x${dispatch}" | cat - "$f" > "/tmp/seeds_dispatch/${base}.dispatch_${dispatch}"
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
        fi
    done
fi

if [ -x "$seed_target" ] && ls /tmp/benchmark_seed_candidates/* 1>/dev/null 2>&1; then
    for f in /tmp/benchmark_seed_candidates/*; do
        [ -f "$f" ] || continue
        if timeout 10s env ASAN_OPTIONS="${ASAN_OPTIONS:-detect_leaks=0:detect_stack_use_after_return=1}" "$seed_target" "$f" >/tmp/seed_replay.log 2>&1; then
            cp "$f" "/tmp/seeds_dispatch/poc_$(basename "$f")"
        fi
    done
fi

if ls /tmp/seeds_dispatch/* 1>/dev/null 2>&1; then
    rm -f "$seed_zip"
    zip -j -q "$seed_zip" /tmp/seeds_dispatch/*
fi
