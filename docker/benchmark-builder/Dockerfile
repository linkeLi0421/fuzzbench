# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG parent_image

# Using multi-stage build to copy Python package dependencies.
FROM gcr.io/fuzzbench/base-image AS base-image

FROM $parent_image

ARG fuzzer
ARG benchmark
ARG debug_builder

ENV FUZZER $fuzzer
ENV BENCHMARK $benchmark
ENV DEBUG_BUILDER $debug_builder


# Install dependencies required by Python3 or Pip3.
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    xz-utils \
    zlib1g-dev \
    libssl-dev \
    libffi-dev

# Keep the parent image's Python. Some historical benchmark images use older
# glibc, so copying a newer Python binary from base-image can make python3
# unusable. Copy only the PyYAML package needed by fuzzers/utils.py.
COPY --from=base-image /usr/local/lib/python3.10/site-packages/yaml /tmp/fuzzbench-python-packages/yaml
RUN python3 - <<'PY'
import shutil
import sysconfig
from pathlib import Path

purelib = Path(sysconfig.get_paths()["purelib"])
purelib.mkdir(parents=True, exist_ok=True)
destination = purelib / "yaml"
if destination.exists():
    shutil.rmtree(destination)
shutil.copytree("/tmp/fuzzbench-python-packages/yaml", destination)
PY

# Copy the entire fuzzers directory tree to allow for module dependencies.
COPY fuzzers $SRC/fuzzers

# Disable LeakSanitizer since ptrace is unavailable in Google Cloud build
# and is not needed during build process.
ENV ASAN_OPTIONS="detect_leaks=0"

COPY benchmarks/$benchmark/benchmark.yaml /

RUN mkdir /opt/fuzzbench/
COPY docker/benchmark-builder/checkout_commit.py /opt/fuzzbench/
RUN export CHECKOUT_COMMIT=$(cat /benchmark.yaml | tr -d ' ' | grep 'commit:' | cut -d ':' -f2) && \
    python3 -u /opt/fuzzbench/checkout_commit.py $CHECKOUT_COMMIT $SRC

COPY docker/benchmark-builder/fuzzer_build /usr/bin/fuzzer_build
RUN echo "Run fuzzer_build to build the target" && if [ -z "$debug_builder" ] ; then fuzzer_build; fi
