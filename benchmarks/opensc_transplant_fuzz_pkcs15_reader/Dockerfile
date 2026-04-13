FROM gcr.io/oss-fuzz-base/base-builder@sha256:87ca1e9e19235e731fac8de8d1892ebe8d55caf18e7aa131346fc582a2034fdd

# Dependencies for building OpenSC.
RUN apt-get update && apt-get install -y --no-install-recommends \
        autoconf automake libtool pkg-config \
        flex bison gettext \
        libssl-dev libreadline-dev \
        libpcsclite-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Full clone — build.sh checks out the target commit, so history is needed.
RUN git clone https://github.com/OpenSC/OpenSC.git /src/opensc

WORKDIR /src/opensc

# Keep ASan stack-use-after-return detection enabled for direct testcase replay.
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"

# Bug transplant patches (re-applied by build.sh after checkout resets source).
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
COPY build.sh $SRC/
