FROM gcr.io/oss-fuzz-base/base-builder@sha256:87ca1e9e19235e731fac8de8d1892ebe8d55caf18e7aa131346fc582a2034fdd

# Dependencies for building nDPI + libpcap.
RUN apt-get update && apt-get install -y --no-install-recommends \
        autoconf automake libtool pkg-config \
        flex bison gettext libbison-dev libfl-dev \
        libjson-c-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Full clone — build.sh checks out the target commit, so history is needed.
RUN git clone https://github.com/ntop/nDPI.git /src/ndpi

WORKDIR /src/ndpi

# Keep ASan stack-use-after-return detection enabled for direct testcase replay.
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"

# Raise libFuzzer's per-alloc / RSS cap from its 2048MB default. Some
# transplanted bugs trigger a ~2GB malloc en route to the real memory-safety
# error; with the default cap libFuzzer aborts with `out-of-memory` and
# `-ignore_ooms=1` silently drops it. libFuzzer-family runners in
# fuzzbench/fuzzers/*/fuzzer.py splice $ADDITIONAL_ARGS onto the target
# command line, so this propagates automatically.
ENV ADDITIONAL_ARGS="-rss_limit_mb=8192"

# Vendored libpcap tarball (offline-build reproducibility,
# sha256: 635237637c5b619bcceba91900666b64d56ecb7be63f298f601ec786ce087094).
COPY libpcap-1.9.1.tar.gz /src/libpcap-1.9.1.tar.gz

# Bug transplant patches (re-applied by build.sh after checkout resets source).
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
# Filtered public ClusterFuzz corpus (dispatch-zero, crash-filtered) as initial seeds.
COPY corpus_seeds*.zip /src/
COPY build.sh $SRC/
