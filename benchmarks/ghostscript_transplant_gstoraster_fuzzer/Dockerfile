FROM gcr.io/oss-fuzz-base/base-builder@sha256:87ca1e9e19235e731fac8de8d1892ebe8d55caf18e7aa131346fc582a2034fdd

# Build-time deps for ghostpdl + cups + freetype.
# Intentionally omit libfontconfig1-dev so ghostpdl's configure disables
# fontconfig — FuzzBench's runner images don't ship libfontconfig.so.1.
RUN apt-get update && apt-get install -y --no-install-recommends \
        autoconf automake libtool pkg-config \
        zlibc liblcms2-dev libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Full clones so build.sh can `git checkout <target_commit>` on ghostpdl.
RUN git clone --branch branch-2.2 --single-branch --depth 1 \
        https://github.com/apple/cups.git /src/cups
RUN git clone --branch VER-2-11-1 --single-branch --depth 1 \
        https://git.savannah.gnu.org/git/freetype/freetype2.git /src/freetype
# Upstream git.ghostscript.com intermittently auth-walls anonymous clones
# (fatal: could not read Username). Use the official Artifex GitHub mirror,
# which carries full history (verified to contain the build.sh checkout commit).
RUN git clone https://github.com/ArtifexSoftware/ghostpdl.git /src/ghostpdl \
    && mkdir /src/ghostpdl/fuzz

# OSS-Fuzz harness seed corpora, dictionaries, and the .cc sources the build
# compiles as fuzz targets.  Kept in-benchmark so the rebase is self-contained.
COPY pdf_seeds /src/pdf_seeds
COPY dicts /src/dicts
COPY gs_fuzzlib.h /src/gs_fuzzlib.h
COPY gstoraster_fuzzer.cc /src/gstoraster_fuzzer.cc

WORKDIR /src/ghostpdl

# Keep ASan stack-use-after-return detection enabled for direct testcase replay.
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"

# Raise libFuzzer's per-alloc / RSS cap from its 2048MB default. Some
# transplanted bugs trigger a ~2GB malloc en route to the real memory-safety
# error; with the default cap libFuzzer aborts with `out-of-memory` and
# `-ignore_ooms=1` silently drops it. libFuzzer-family runners in
# fuzzbench/fuzzers/*/fuzzer.py splice $ADDITIONAL_ARGS onto the target
# command line, so this propagates automatically.
ENV ADDITIONAL_ARGS="-rss_limit_mb=8192"
# ghostpdl's startup path fires recoverable UBSAN "left shift of negative
# value" in base/gsiorom.c, base/gxpath.c, base/gspath.c, psi/imainarg.c, etc.
# on every run. Without halt_on_error=0 and exitcode=0, afl++ sees exit=1
# and rejects every seed during calibration ("We need at least one valid
# input seed that does not crash!"). AFL_SKIP_CRASHES is belt-and-braces
# so afl++ tolerates any remaining UBSAN abort instead of aborting itself.
ENV UBSAN_OPTIONS="halt_on_error=0:print_stacktrace=0:exitcode=0"
ENV AFL_SKIP_CRASHES=1

# Bug transplant patches (re-applied by build.sh after checkout resets source).
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
# Filtered public ClusterFuzz corpus (dispatch-zero, crash-filtered) as initial seeds.
COPY corpus_seeds*.zip /src/
COPY build.sh $SRC/
