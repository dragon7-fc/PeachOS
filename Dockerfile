FROM ubuntu:18.04

RUN apt update
RUN apt install -y nasm
RUN apt install -y qemu-system-x86
RUN apt install -y build-essential \
        bison \
        libgmp3-dev \
        libmpc-dev \
        libmpfr-dev \
        texinfo \
        libisl-dev 
RUN apt install -y libcloog-isl-dev 

RUN apt install wget
RUN mkdir /root/src
WORKDIR /root/src
RUN wget https://mirror.ossplanet.net/gnu/binutils/binutils-2.35.tar.xz
RUN tar Jxvf binutils-2.35.tar.xz
RUN mkdir build-binutils
WORKDIR /root/src/build-binutils
ENV PREFIX="/root/opt/cross"
ENV TARGET=i686-elf
ENV PATH="$PREFIX/bin:$PATH"
RUN ../binutils-2.35/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror && make && make install

WORKDIR /root/src
RUN wget http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-10.2.0/gcc-10.2.0.tar.xz
RUN tar Jxvf gcc-10.2.0.tar.xz
RUN mkdir build-gcc
WORKDIR /root/src/build-gcc
RUN ../gcc-10.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
RUN make all-gcc
RUN make all-target-libgcc
RUN make install-gcc
RUN make install-target-libgcc

RUN apt install -y gdb

# dumpelf
RUN apt install -y pax-utils

RUN apt install less \
        bsdmainutils

WORKDIR /root
CMD ["/bin/bash"]
