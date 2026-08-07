# Self-contained build environment for the htslib bug-transplant benchmark.
# Previously this was `FROM htslib-merge:dd6f0b72` (a separately-committed merge
# container image). That made the benchmark unbuildable on any machine that
# lacked that image. Instead we reconstruct the same environment directly from
# the pinned OSS-Fuzz base-builder plus a full htslib clone, mirroring the
# OSS-Fuzz htslib project Dockerfile at oss-fuzz commit c15017cf.
#
# Base-builder is pinned to a focal (Ubuntu 20.04) digest, NOT the xenial-era
# image matched to htslib's 2019 target commit: the modern fuzzer builder
# layers (libafl/aflplusplus/honggfuzz/...) run `apt-get remove -y llvm-10` and
# install llvm-17, which require a focal base. htslib's 2019 target commit
# (dd6f0b72) still compiles cleanly on focal.
FROM gcr.io/oss-fuzz-base/base-builder@sha256:4af219498733484fcec27ca3b6ceda96ed38aecb83fcd47f930811f5d5fad1b9

RUN apt-get update && apt-get install -y \
    make autoconf automake zlib1g-dev libbz2-dev liblzma-dev \
    libcurl4-gnutls-dev libssl-dev wget unzip

# Full clone (no --depth) so build.sh can `git checkout` the 2019 target commit.
RUN git clone https://github.com/samtools/htslib.git htslib

WORKDIR /src/htslib

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
