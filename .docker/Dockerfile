FROM gcc:14.1
ARG TARGETARCH

RUN set -ex && \
    apt-get update && \
    apt-get install -y --no-install-recommends gpg git lsb-release wget software-properties-common ninja-build libgmp10 libmpfr6 libgmp-dev libmpfr-dev && \
    apt-mark auto libgmp-dev libmpfr-dev

ENV CC=/usr/local/bin/gcc

ENV GDB_VERSION=14.2
RUN wget https://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.gz && \
	tar -xf gdb-${GDB_VERSION}.tar.gz -C /tmp && rm gdb-${GDB_VERSION}.tar.gz && \
	cd /tmp/gdb-${GDB_VERSION} && \
	./configure --prefix=/usr/local && make && make install && \
	rm -rf /tmp/gdb-${GDB_VERSION}

ENV GO_VERSION=1.22.5
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-${TARGETARCH}.tar.gz && \
    tar -xf go${GO_VERSION}.linux-${TARGETARCH}.tar.gz -C /usr/local && \
    rm go${GO_VERSION}.linux-${TARGETARCH}.tar.gz

ENV CMAKE_VERSION=3.30.0
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz && \
    tar -xf cmake-${CMAKE_VERSION}.tar.gz -C /tmp && rm cmake-${CMAKE_VERSION}.tar.gz && \
    cd /tmp/cmake-${CMAKE_VERSION} && \
    ./bootstrap && make && make install && \
    rm -rf /usr/src/cmake-${CMAKE_VERSION}

ENV PATH="${PATH}:/usr/local/go/bin"

RUN set -ex && \
    GOBIN=/usr/local/go/bin go install github.com/bazelbuild/bazelisk@latest && \
    GOBIN=/usr/local/go/bin go install github.com/bazelbuild/buildtools/buildifier@latest && \
    ln -s /usr/local/go/bin/bazelisk /usr/local/bin/bazel

ENV LLVM_VERSION=18
RUN set -ex && \
    wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh ${LLVM_VESION} all || echo "" && \
    # Known bug, we have to run llvm.sh twice
    apt-get update && \
    ./llvm.sh ${LLVM_VERSION} all && \
    rm llvm.sh

ENV VALGRIND_VERSION=3.23.0
RUN set -ex && \
    wget https://sourceware.org/pub/valgrind/valgrind-${VALGRIND_VERSION}.tar.bz2 && \
    tar -xf valgrind-${VALGRIND_VERSION}.tar.bz2 -C /tmp && rm valgrind-${VALGRIND_VERSION}.tar.bz2 && \
    cd /tmp/valgrind-${VALGRIND_VERSION} && \
    ./configure && make && make install && \
    rm -rf /usr/src/valgrind-${VALGRIND_VERSION}

# Make GDB avoid security checks and autoload the python pretty-printing
RUN mkdir -p /root/.config/gdb &&\
    echo "set auto-load safe-path /" >/root/.config/gdb/gdbinit

# Cleanup unneeded packages
RUN apt-get autoremove -y