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

# ndpi's protocol-detection walk has a pre-existing shallow UB shift in
# ndpi_utils.c:218 (ndpi_net_match called from starcraft/etc.). With
# halt_on_error=1 that shadow UB aborts execution before any fuzzing input
# can reach the transplanted target bug — 16/43 testcases in this benchmark's
# crashes/ were formerly masked by it. Keep UBs logged but recoverable at
# runtime so fuzzers explore past them to the real memory-safety bugs.
ENV UBSAN_OPTIONS="print_stacktrace=0:halt_on_error=0"

# Vendored libpcap tarball (offline-build reproducibility,
# sha256: 635237637c5b619bcceba91900666b64d56ecb7be63f298f601ec786ce087094).
COPY libpcap-1.9.1.tar.gz /src/libpcap-1.9.1.tar.gz

# Bug transplant patches (re-applied by build.sh after checkout resets source).
COPY patches/ /src/patches/
COPY build.sh $SRC/
