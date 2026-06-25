FROM gcr.io/oss-fuzz-base/base-builder@sha256:87ca1e9e19235e731fac8de8d1892ebe8d55caf18e7aa131346fc582a2034fdd

# Dependencies for building ntopng + its vendored third-party libs.
RUN apt-get update && apt-get install -y --no-install-recommends \
        make autoconf automake libtool ninja-build \
        liblzma-dev libzstd-dev pkg-config libglib2.0-dev \
        groff libxml2-dev libcurl4-openssl-dev libsqlite3-dev \
        flex bison cmake wget unzip \
    && rm -rf /var/lib/apt/lists/*

# Full clone — build.sh checks out the target commit, so history is needed.
RUN git clone https://github.com/ntop/ntopng.git /src/ntopng
ENV NTOPNG_HOME=/src/ntopng

# nDPI pinned to a commit from 2023-05-20 (two days before the ntopng target
# commit b7b2810e on 2023-05-22). Keeps the benchmark reproducible across
# machines while matching the API ntopng expected at the target commit.
RUN git clone https://github.com/ntop/nDPI.git /src/nDPI \
    && git -C /src/nDPI checkout 86b56646b532660a7efeb55498766e14ce8bc2c9
ENV NDPI_HOME=/src/nDPI

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

# Other static-linked deps fetched from GitHub release URLs. GitHub release
# tarballs are content-addressed by tag, so these are stable on subsequent
# docker builds and don't need to be vendored in the repo.
ADD https://github.com/zeromq/libzmq/releases/download/v4.3.4/zeromq-4.3.4.tar.gz /src/zeromq-4.3.4.tar.gz
ADD https://github.com/json-c/json-c/archive/refs/tags/json-c-0.16-20220414.tar.gz /src/json-c-0.16-20220414.tar.gz
ADD https://github.com/maxmind/libmaxminddb/releases/download/1.7.1/libmaxminddb-1.7.1.tar.gz /src/libmaxminddb-1.7.1.tar.gz

# Bug transplant patches (re-applied by build.sh after checkout resets source).
COPY patches/ /src/patches/
COPY build.sh $SRC/
