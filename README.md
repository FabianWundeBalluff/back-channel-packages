# back-channel-packages 
## create parent image (Ubuntu 18.04)
```shell
cd <check out dir >/ubuntu-18.04
sudo docker build -t ubuntu:18.04Balluff -f ./dockerfile ./
```

## create  mosquitto (Ubuntu 18.04)

``` shell
./cpack_mosquitto.sh
```

