# Self-contained build for the c-blosc2 bug-transplant benchmark.
#
# This previously used `FROM c-blosc2-merge:79e921d9` -- an image built
# out-of-band (via `docker commit`) during transplant verification. That image
# is not reproducible from this repo and is lost whenever Docker images are
# pruned (e.g. on reboot), which breaks every build of this benchmark.
#
# Mirroring the self-contained sibling transplant benchmarks (ndpi, ghostscript,
# htslib, ...), we build from the pinned OSS-Fuzz base-builder and clone the
# project ourselves so build.sh can `git checkout` the target commit and apply
# the transplant patches.
FROM gcr.io/oss-fuzz-base/base-builder@sha256:87ca1e9e19235e731fac8de8d1892ebe8d55caf18e7aa131346fc582a2034fdd

# c-blosc2 builds with CMake and vendors its own codecs (lz4 / zstd / zlib),
# so cmake is the only extra build dependency. base-builder already provides
# clang/CFLAGS, lld, make, git, python3, zip/unzip.
RUN apt-get update && apt-get install -y --no-install-recommends \
        cmake \
    && rm -rf /var/lib/apt/lists/*

# Full clone -- build.sh checks out the target commit
# (79e921d904d46fc9edc292e02a48f1aa54567a7d), so the history is needed.
RUN git clone https://github.com/Blosc/c-blosc2.git /src/c-blosc2

WORKDIR /src/c-blosc2

# Keep ASan stack-use-after-return detection enabled for direct testcase replay.
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"

# Raise libFuzzer's per-alloc / RSS cap from its 2048MB default. Some
# transplanted bugs (e.g. c-blosc2 OSV-2021-464) trigger a ~2GB malloc en route
# to the real memory-safety error; with the default cap libFuzzer aborts with
# `out-of-memory` and `-ignore_ooms=1` silently drops it. libFuzzer-family
# runners in fuzzbench/fuzzers/*/fuzzer.py splice $ADDITIONAL_ARGS onto the
# target command line, so this propagates automatically.
ENV ADDITIONAL_ARGS="-rss_limit_mb=8192"

# Bug transplant patches (re-applied by build.sh after checkout_commit.py resets
# the source tree).
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
COPY build.sh $SRC/
