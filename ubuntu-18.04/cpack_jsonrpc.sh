#!/bin/bash

rm -rf $PWD/libjson-rpc-cpp
mkdir -p $PWD/libjson-rpc-cpp/build
mkdir -p $PWD/libjson-rpc-cpp/package
docker run --rm -u $(id -u):$(id -g) -it \
    -v $PWD/libjson-rpc-cpp:$PWD/libjson-rpc-cpp \
    -w $PWD/libjson-rpc-cpp/build \
    ubuntu:18.04Balluff \
    cmake \
        -G "Ninja" \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DCPACK_GENERATOR=DEB \
        -DCPACK_DEBIAN_PACKAGE_MAINTAINER=backchannel \
        -DCPACK_PACKAGE_DIRECTORY=$PWD/libjson-rpc-cpp/package \
        -DHTTP_CLIENT=OFF \
	-DHTTP_SERVER=OFF \
	-DREDIS_CLIENT=OFF \
	-DREDIS_SERVER=OFF \
	-DHUNTER_ENABLED=OFF \
        -DCOMPILE_TESTS=OFF \
        /home/backchannel/git/libjson-rpc-cpp;

docker run --rm -u $(id -u):$(id -g) -it \
        -v $PWD/libjson-rpc-cpp:$PWD/libjson-rpc-cpp \
        -w $PWD/libjson-rpc-cpp/build \
        ubuntu:18.04Balluff \
        ninja package;
mv $PWD/libjson-rpc-cpp/package/*.deb $PWD
rm -rf $PWD/libjson-rpc-cpp






