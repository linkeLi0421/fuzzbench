# Use the committed merge container as base for identical build environment.
# This image has the exact same OS packages, library versions, and source tree
# that were used during bug transplant verification.
FROM libredwg-merge:a67ea97d

# The merge container runs as a non-root user (agent).  Switch back to root
# so downstream Dockerfiles (AFL++'s builder, benchmark-builder, etc.) can
# install packages and write to system directories.
USER root

# docker commit can snapshot a broken apt state - fix it so downstream
# Dockerfiles (e.g. AFL++'s builder.Dockerfile) can apt-get install.
RUN rm -rf /var/lib/apt/lists/* && mkdir -p /var/lib/apt/lists/partial && apt-get update

# libredwg's autotools build leaves __bug_dispatch.o and llvmfuzz.o at the
# project root after the merge-time ASAN compile. AFL's builder.Dockerfile
# later runs `ar r /libAFL.a *.o` in WORKDIR, which would archive those stale
# objects into libAFL.a and cause a duplicate-symbol link error when build.sh
# links the fuzz target. Strip them from the image before any fuzzer layer
# is built on top.
RUN rm -f /src/libredwg/*.o

WORKDIR /src/libredwg

# Keep ASan stack-use-after-return detection enabled for direct testcase replay.
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"

# Raise libFuzzer's per-alloc / RSS cap from its 2048MB default. Some
# transplanted bugs trigger a ~2GB malloc en route to the real memory-safety
# error; with the default cap libFuzzer aborts with `out-of-memory` and
# `-ignore_ooms=1` silently drops it. libFuzzer-family runners in
# fuzzbench/fuzzers/*/fuzzer.py splice $ADDITIONAL_ARGS onto the target
# command line, so this propagates automatically.
ENV ADDITIONAL_ARGS="-rss_limit_mb=8192"

# Bug transplant patches (re-applied by build.sh after checkout_commit.py resets source)
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
COPY build.sh $SRC/
