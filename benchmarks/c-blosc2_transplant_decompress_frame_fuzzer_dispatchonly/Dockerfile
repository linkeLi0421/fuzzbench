# Self-contained (merge-base c-blosc2-merge:79e921d9 unavailable off-CloudLab).
# base-builder pinned to the standard digest; source cloned fresh, build.sh
# re-checkouts the target commit and re-applies patches.
FROM gcr.io/oss-fuzz-base/base-builder@sha256:87ca1e9e19235e731fac8de8d1892ebe8d55caf18e7aa131346fc582a2034fdd
RUN apt-get update && apt-get install -y --no-install-recommends \
        make autoconf automake libtool cmake \
    && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/Blosc/c-blosc2.git /src/c-blosc2
WORKDIR /src/c-blosc2
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"
ENV ADDITIONAL_ARGS="-rss_limit_mb=8192"
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
COPY build.sh $SRC/
