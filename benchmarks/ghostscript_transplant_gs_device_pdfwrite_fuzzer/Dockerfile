FROM gcr.io/oss-fuzz-base/base-builder@sha256:87ca1e9e19235e731fac8de8d1892ebe8d55caf18e7aa131346fc582a2034fdd

# Dependencies for building Ghostscript + CUPS + FreeType.
# Intentionally omit libfontconfig1-dev so ghostpdl's configure disables
# fontconfig — FuzzBench's runner images don't ship libfontconfig.so.1.
RUN apt-get update && apt-get install -y --no-install-recommends \
        autoconf automake libtool pkg-config \
        liblcms2-dev libpng-dev libtiff-dev \
        libfreetype6-dev libjbig2dec0-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Full clones — build.sh checks out the target ghostpdl commit, so history is
# needed for git checkout. cups is tracked on branch-2.2 (per OSS-Fuzz's pin)
# and freetype is pinned at VER-2-12-1 (matches the original merge environment).
RUN git clone --branch branch-2.2 --single-branch https://github.com/apple/cups.git /src/cups
RUN git clone --branch VER-2-12-1 --single-branch https://git.savannah.gnu.org/git/freetype/freetype2.git /src/freetype
RUN git clone https://github.com/ArtifexSoftware/ghostpdl.git /src/ghostpdl

# Keep ASan stack-use-after-return detection enabled for direct testcase replay.
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"

# Raise libFuzzer's per-alloc / RSS cap from its 2048MB default. Some
# transplanted bugs trigger a ~2GB malloc en route to the real memory-safety
# error; with the default cap libFuzzer aborts with `out-of-memory` and
# `-ignore_ooms=1` silently drops it. libFuzzer-family runners in
# fuzzbench/fuzzers/*/fuzzer.py splice $ADDITIONAL_ARGS onto the target
# command line, so this propagates automatically.
ENV ADDITIONAL_ARGS="-rss_limit_mb=8192"

# Ghostscript fuzz harnesses + dictionaries + seeds, as shipped by OSS-Fuzz
# at the commit that introduced gs_device_pdfwrite_fuzzer (a5352add9).
COPY ghostscript_files/gs_fuzzlib.h /src/gs_fuzzlib.h
COPY ghostscript_files/pdf_seeds /src/pdf_seeds
COPY ghostscript_files/dicts /src/dicts

# Bug transplant patches, harness_sources, and per-bug testcases.
# harness_sources contains the dispatch-aware gs_device_pdfwrite_fuzzer.cc
# which build.sh copies into /src before the compile step.
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
COPY build.sh $SRC/

WORKDIR /src/ghostpdl
