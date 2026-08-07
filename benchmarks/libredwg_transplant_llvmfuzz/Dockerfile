# Self-contained (merge-base libredwg-merge:a67ea97d unavailable off-CloudLab).
FROM gcr.io/oss-fuzz-base/base-builder@sha256:87ca1e9e19235e731fac8de8d1892ebe8d55caf18e7aa131346fc582a2034fdd
RUN apt-get update && apt-get install -y --no-install-recommends \
        autoconf automake libtool texinfo \
    && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/LibreDWG/libredwg /src/libredwg
WORKDIR /src/libredwg
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"
ENV ADDITIONAL_ARGS="-rss_limit_mb=8192"
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
# Filtered public ClusterFuzz corpus (dispatch-zero, crash-filtered) as initial seeds.
COPY corpus_seeds*.zip /src/
COPY llvmfuzz.options $SRC/
COPY build.sh $SRC/
