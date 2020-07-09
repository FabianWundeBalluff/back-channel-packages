#!/bin/bash

rm -rf $PWD/libjson-rpc-cpp
mkdir -p $PWD/libjson-rpc-cpp/git
mkdir -p $PWD/libjson-rpc-cpp/build
mkdir -p $PWD/libjson-rpc-cpp/package

git -C $PWD/libjson-rpc-cpp/git clone https://github.com/Balluff/libjson-rpc-cpp.git -b feature/cmake
sudo docker run --rm -u $(id -u):$(id -g) -it \
    -v $PWD/libjson-rpc-cpp:$PWD/libjson-rpc-cpp \
    -w $PWD/libjson-rpc-cpp/build \
    opensuse:15.1Balluff \
    cmake \
        -G "Ninja" \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DCPACK_GENERATOR=RPM \
        -DCPACK_DEBIAN_PACKAGE_MAINTAINER=backchannel \
        -DCPACK_PACKAGE_DIRECTORY=$PWD/libjson-rpc-cpp/package \
        -DHTTP_CLIENT=OFF \
	-DHTTP_SERVER=OFF \
	-DREDIS_CLIENT=OFF \
	-DREDIS_SERVER=OFF \
	-DHUNTER_ENABLED=OFF \
        -DCOMPILE_TESTS=OFF \
        ../git/libjson-rpc-cpp;

sudo docker run --rm -u $(id -u):$(id -g) -it \
        -v $PWD/libjson-rpc-cpp:$PWD/libjson-rpc-cpp \
        -w $PWD/libjson-rpc-cpp/build \
        opensuse:15.1Balluff \
        ninja package;
mv $PWD/libjson-rpc-cpp/package/*.rpm $PWD
rm -rf $PWD/libjson-rpc-cpp






