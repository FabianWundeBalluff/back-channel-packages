#!/bin/bash
rm -rf $PWD/mosquitto 
mkdir -p $PWD/mosquitto/build
mkdir -p $PWD/mosquitto/package
docker run --rm -u $(id -u):$(id -g) -it \
    -v $PWD/mosquitto:$PWD/mosquitto \
    -w $PWD/mosquitto/build \
    ubuntu:18.04Balluff \
    cmake \
        -G "Ninja" \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DCPACK_GENERATOR=DEB \
	-DCPACK_DEBIAN_PACKAGE_MAINTAINER=backchannel \
	-DCPACK_PACKAGE_DIRECTORY=$PWD/mosquitto/package \
	-DDOCUMENTATION=OFF \
	-DWITH_TLS=OFF \
        /home/backchannel/git/mosquitto;

docker run --rm -u $(id -u):$(id -g) -it \
	-v $PWD/mosquitto:$PWD/mosquitto \
	-w $PWD/mosquitto/build \
	ubuntu:18.04Balluff \
	ninja package;
mv $PWD/mosquitto/package/*.deb $PWD
rm -rf $PWD/mosquitto

