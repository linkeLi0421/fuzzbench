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

# Clean stale object files from the merge container build so that downstream
# fuzzer builders (e.g., AFL's `ar r /libAFL.a *.o` step) don't accidentally
# archive llvmfuzz.o from the prior ASAN compile into the fuzzing engine.
RUN find /src -maxdepth 4 -name '*.o' -delete 2>/dev/null || true

# Use /src (not /src/libredwg) as WORKDIR so downstream RUN steps that glob
# *.o in the current directory (e.g., AFL builder.Dockerfile) don't pick up
# project object files.
WORKDIR /src

# Keep ASan stack-use-after-return detection enabled for direct testcase replay.
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"

# Bug transplant patches (re-applied by build.sh after checkout_commit.py resets source)
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
COPY build.sh $SRC/
