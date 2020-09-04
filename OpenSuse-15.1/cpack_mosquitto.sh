#!/bin/bash
rm -rf $PWD/mosquitto 
mkdir -p $PWD/mosquitto/git
mkdir -p $PWD/mosquitto/build
mkdir -p $PWD/mosquitto/package

git -C $PWD/mosquitto/git clone https://github.com/Balluff/mosquitto.git -b feature/cpack

sudo docker run --rm -u $(id -u):$(id -g) -it \
    -v $PWD/mosquitto:$PWD/mosquitto \
    -w $PWD/mosquitto/build \
    opensuse:15.1Balluff \
    cmake \
        -G "Ninja" \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DCPACK_GENERATOR=RPM \
	-DCPACK_DEBIAN_PACKAGE_MAINTAINER=backchannel \
	-DCPACK_PACKAGE_DIRECTORY=$PWD/mosquitto/package \
	-DDOCUMENTATION=OFF \
	-DWITH_TLS=OFF \
        ../git/mosquitto;

sudo docker run --rm -u $(id -u):$(id -g) -it \
	-v $PWD/mosquitto:$PWD/mosquitto \
	-w $PWD/mosquitto/build \
	opensuse:15.1Balluff \
	ninja package;
mv $PWD/mosquitto/package/*.rpm $PWD
rm -rf $PWD/mosquitto

