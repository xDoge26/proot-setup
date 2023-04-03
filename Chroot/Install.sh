#!/bin/sh

su -c mkdir /data/chroot
su -c cd /data/chroot
wget http://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.2-base-arm64.tar.gz 
tar -xvpf *.tar.gz && sudo rm *.tar.gz && clear &&
mkdir /data/chroot/sdcard 
