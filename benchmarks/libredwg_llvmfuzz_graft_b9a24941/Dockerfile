# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

FROM gcr.io/oss-fuzz-base/base-builder@sha256:4af219498733484fcec27ca3b6ceda96ed38aecb83fcd47f930811f5d5fad1b9
RUN apt-get update && apt-get install -y autoconf libtool texinfo wget unzip
RUN git clone https://github.com/LibreDWG/libredwg

WORKDIR $SRC
# Keep ASan stack-use-after-return detection enabled for direct
# testcase replay; some transplanted bugs are stack-use-after-return
# and are invisible without it.
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"

# Raise libFuzzer's per-alloc / RSS cap from its 2048MB default. Some
# transplanted bugs (e.g. c-blosc2 OSV-2021-464) make a ~2GB malloc en
# route to the real memory-safety error; under the default cap
# libFuzzer aborts with `out-of-memory` before the bug fires.
# libFuzzer-family runners splice $ADDITIONAL_ARGS onto the target
# command line, so this propagates automatically.
ENV ADDITIONAL_ARGS="-rss_limit_mb=8192"

# Bug transplant patches
COPY patches/ /src/patches/
# Public ClusterFuzz corpus (dispatch-zero, crash-filtered):
# the benchmark's initial seeds.
COPY corpus_seeds*.zip /src/
COPY build.sh $SRC/
COPY llvmfuzz.options $SRC/
