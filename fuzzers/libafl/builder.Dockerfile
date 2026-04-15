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
FROM $parent_image

# Remove any preexisting Rust install (parent image ships one at /rust),
# then install a fresh nightly toolchain under fixed root paths. Pinning
# RUSTUP_HOME/CARGO_HOME avoids cross-device rename errors when /rust is
# on a different overlay layer than the container's writable root.
ENV RUSTUP_HOME=/root/.rustup \
    CARGO_HOME=/root/.cargo \
    PATH=/root/.cargo/bin:$PATH
RUN rm -f /usr/local/bin/cargo /usr/local/bin/rustc /usr/local/bin/rustup && \
    rm -rf /rust /home/agent/.cargo /home/agent/.rustup \
           /root/.cargo /root/.rustup && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > /rustup.sh && \
    sh /rustup.sh --default-toolchain nightly -y --no-modify-path && \
    rm /rustup.sh && \
    ln -s /root/.cargo/bin/cargo /usr/local/bin/cargo && \
    ln -s /root/.cargo/bin/rustc /usr/local/bin/rustc && \
    ln -s /root/.cargo/bin/rustup /usr/local/bin/rustup

# Install dependencies.
RUN apt-get update && \
    apt-get remove -y llvm-10 && \
    apt-get install -y \
        build-essential \
        lsb-release wget software-properties-common gnupg && \
    apt-get install -y wget libstdc++5 libtool-bin automake flex bison \
        libglib2.0-dev libpixman-1-dev python3-setuptools unzip \
        apt-utils apt-transport-https ca-certificates joe curl && \
    wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && ./llvm.sh 17

RUN wget https://gist.githubusercontent.com/tokatoka/26f4ba95991c6e33139999976332aa8e/raw/698ac2087d58ce5c7a6ad59adce58dbfdc32bd46/createAliases.sh && chmod u+x ./createAliases.sh && ./createAliases.sh

# Download libafl.
RUN git clone https://github.com/AFLplusplus/LibAFL /libafl

# Checkout a current commit
RUN cd /libafl && git pull && git checkout f856092f3d393056b010fcae3b086769377cba18 || true
# Note that due a nightly bug it is currently fixed to a known version on top!

# Compile libafl.
RUN cd /libafl && \
    unset CFLAGS CXXFLAGS && \
    export LIBAFL_EDGES_MAP_SIZE=2621440 && \
    cd ./fuzzers/fuzzbench/fuzzbench && \
    cargo build --profile release-fuzzbench --features no_link_main

# Auxiliary weak references.
RUN cd /libafl/fuzzers/fuzzbench/fuzzbench && \
    clang -c stub_rt.c && \
    ar r /stub_rt.a stub_rt.o
