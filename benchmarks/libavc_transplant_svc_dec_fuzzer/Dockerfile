# Use the committed merge container as base for identical build environment.
# This image has the exact same OS packages, library versions, and source tree
# that were used during bug transplant verification.
FROM libavc-merge:c38af025

# The merge container runs as a non-root user (agent).  Switch back to root
# so downstream Dockerfiles (AFL++'s builder, benchmark-builder, etc.) can
# install packages and write to system directories.
USER root
ENV HOME=/root

# docker commit can snapshot a broken apt state - fix it so downstream
# Dockerfiles (e.g. AFL++'s builder.Dockerfile) can apt-get install.
RUN rm -rf /var/lib/apt/lists/* && mkdir -p /var/lib/apt/lists/partial && apt-get update

# Remove stale OSS-Fuzz Rust wrapper (/usr/local/bin/cargo points to /rust/bin/cargo
# which doesn't exist in the merge image). libafl's builder installs a fresh
# rustup toolchain; the dead shim must be out of the way first.
RUN rm -f /usr/local/bin/cargo /usr/local/bin/rustc

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
# Don't abort on shallow UB (integer overflow / bad shift in base libavc);
# otherwise fuzzers burn all their time rediscovering the same 2-3 UB sites
# instead of reaching transplanted bugs deeper in the decode path.
ENV UBSAN_OPTIONS="halt_on_error=0:print_stacktrace=0"

# Bug transplant patches (re-applied by build.sh after checkout_commit.py resets source)
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
COPY build.sh $SRC/
