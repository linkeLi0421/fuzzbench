# Copyright 2023 Google LLC
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
RUN apt-get update && apt-get install -y make autoconf automake libtool ninja-build wget unzip libpcap-dev \
    liblzma-dev libzstd-dev pkg-config libglib2.0-dev groff libxml2-dev \
    libcurl4-openssl-dev libsqlite3-dev flex bison

# Ntopng
RUN git clone  https://github.com/ntop/ntopng.git ntopng
ENV NTOPNG_HOME=$SRC/ntopng


### Fuzzing dependencies ###

# Build libprotobuf-mutator
RUN git clone  https://github.com/google/libprotobuf-mutator.git
RUN mkdir libprotobuf-mutator/build; cd libprotobuf-mutator/build; \
    cmake .. -GNinja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLIB_PROTO_MUTATOR_DOWNLOAD_PROTOBUF=ON -DLIB_PROTO_MUTATOR_TESTING=OFF -DCMAKE_BUILD_TYPE=Release; \
    ninja;

### Dependencies that need static linking ###

ADD https://www.tcpdump.org/release/libpcap-1.9.1.tar.gz libpcap-1.9.1.tar.gz
RUN tar -xvzf libpcap-1.9.1.tar.gz
ADD https://github.com/zeromq/libzmq/releases/download/v4.3.5/zeromq-4.3.5.tar.gz zeromq-4.3.5.tar.gz
RUN tar -xvzf zeromq-4.3.5.tar.gz
ADD https://github.com/json-c/json-c/archive/refs/tags/json-c-0.17-20230812.tar.gz json-c-0.17-20230812.tar.gz
RUN tar -xvzf json-c-0.17-20230812.tar.gz
ADD https://github.com/maxmind/libmaxminddb/releases/download/1.7.1/libmaxminddb-1.7.1.tar.gz libmaxminddb-1.7.1.tar.gz
RUN tar -xvzf libmaxminddb-1.7.1.tar.gz;

### ntopng dependecies ###

RUN git clone  https://github.com/ntop/nDPI.git nDPI \
 && git -C nDPI checkout --force 5424d144242c5b85176465acb7376237d80c6d91
ENV NDPI_HOME=$SRC/nDPI


WORKDIR ntopng

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
