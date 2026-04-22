FROM gcr.io/oss-fuzz-base/base-builder@sha256:87ca1e9e19235e731fac8de8d1892ebe8d55caf18e7aa131346fc582a2034fdd

# Build-time deps for ghostpdl + cups + freetype.
# Intentionally omit libfontconfig1-dev so ghostpdl's configure disables
# fontconfig — FuzzBench's runner images don't ship libfontconfig.so.1.
RUN apt-get update && apt-get install -y --no-install-recommends \
        autoconf automake libtool pkg-config \
        zlibc liblcms2-dev libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Full clones so build.sh can `git checkout <target_commit>` on ghostpdl.
RUN git clone --branch branch-2.2 --single-branch --depth 1 \
        https://github.com/apple/cups.git /src/cups
RUN git clone --branch VER-2-11-1 --single-branch --depth 1 \
        https://git.savannah.gnu.org/git/freetype/freetype2.git /src/freetype
RUN git clone https://git.ghostscript.com/ghostpdl.git /src/ghostpdl \
    && mkdir /src/ghostpdl/fuzz

# OSS-Fuzz harness seed corpora, dictionaries, and the .cc sources the build
# compiles as fuzz targets.  Kept in-benchmark so the rebase is self-contained.
COPY pdf_seeds /src/pdf_seeds
COPY dicts /src/dicts
COPY gs_fuzzlib.h /src/gs_fuzzlib.h
COPY gstoraster_fuzzer.cc /src/gstoraster_fuzzer.cc

WORKDIR /src/ghostpdl

# Keep ASan stack-use-after-return detection enabled for direct testcase replay.
ENV ASAN_OPTIONS="detect_leaks=0:detect_stack_use_after_return=1"

# Bug transplant patches (re-applied by build.sh after checkout resets source).
COPY patches/ /src/patches/
COPY seeds/ /src/benchmark_seeds/
COPY build.sh $SRC/
