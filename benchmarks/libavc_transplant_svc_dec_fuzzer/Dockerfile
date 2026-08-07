# Self-contained build for the libavc bug-transplant benchmark.
#
# This previously used `FROM libavc-merge:c38af025` -- an image built out-of-band
# (via `docker commit`) during transplant verification. That image is not
# reproducible from this repo and is lost whenever Docker images are pruned,
# which breaks every build of this benchmark. Mirroring the self-contained
# sibling transplant benchmarks (c-blosc2, htslib, ndpi, ...), we build from the
# pinned OSS-Fuzz base-builder and clone libavc ourselves so build.sh can
# `git checkout` the target commit and apply the transplant patches. Base image
# and dependencies mirror the OSS-Fuzz libavc project Dockerfile.
FROM gcr.io/oss-fuzz-base/base-builder@sha256:87ca1e9e19235e731fac8de8d1892ebe8d55caf18e7aa131346fc582a2034fdd

RUN apt-get update && apt-get install -y --no-install-recommends \
        wget cmake \
    && rm -rf /var/lib/apt/lists/*

# Full clone (no --depth) so build.sh can `git checkout` the target commit
# (c38af025abf0040f6693d15f4ce2e878a728cfee).
RUN git clone https://android.googlesource.com/platform/external/libavc /src/libavc

# libavc's fuzzer/ossfuzz.sh unconditionally copies this seed corpus into $OUT;
# the OSS-Fuzz libavc Dockerfile provides it the same way. Without it the build
# aborts (`cp: cannot stat .../avc_dec_fuzzer_seed_corpus.zip`). The transplant
# benchmark fuzzes svc_dec_fuzzer and repackages its own seeds, so this file is
# only needed to satisfy that copy.
ADD https://storage.googleapis.com/android_media/external/libavc/fuzzer/avc_dec_fuzzer_seed_corpus.zip $SRC/

WORKDIR /src/libavc

# Keep ASan stack-use-after-return detection enabled for direct testcase replay.
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"

# Raise libFuzzer's per-alloc / RSS cap from its 2048MB default. Some
# transplanted bugs trigger a ~2GB malloc en route to the real memory-safety
# error; with the default cap libFuzzer aborts with `out-of-memory` and
# `-ignore_ooms=1` silently drops it. libFuzzer-family runners in
# fuzzbench/fuzzers/*/fuzzer.py splice $ADDITIONAL_ARGS onto the target
# command line, so this propagates automatically.
ENV ADDITIONAL_ARGS="-rss_limit_mb=8192"

# Bug transplant patches (re-applied by build.sh after git checkout resets source)
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
# Filtered public ClusterFuzz corpus (dispatch-zero, crash-filtered) as initial seeds.
COPY corpus_seeds*.zip /src/
COPY build.sh $SRC/
