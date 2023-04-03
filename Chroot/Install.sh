#!/bin/sh

UBUNTU="/data/chroot"
BUSYBOX="/data/adb/magisk/busybox"

mkdir /data/chroot
mkdir /data/chroot/sdcard
cd /data/chroot
$BUSYBOX wget http://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.2-base-arm64.tar.gz 
$BUSYBOX tar -xvpf *.tar.gz 
rm *.tar.gz 
 
