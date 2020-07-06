# back-channel-packages 
## create parent image (Ubuntu 18.04)
```shell
cd <check out dir>/ubuntu-18.04
sudo docker build -t ubuntu:18.04Balluff -f ./dockerfile ./
```

## create  mosquitto (Ubuntu 18.04)

``` shell
cd <check out dir>/ubuntu-18.04
./cpack_mosquitto.sh
```

Executing this script will create an Debian Package in the current directory

## create  libjson-rpc-cpp (Ubuntu 18.04)
``` shell
cd <check out dir>/ubuntu-18.04
./cpack_jsonrpc.sh
```
