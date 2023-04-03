#!/bin/sh

CHROOT="/data/chroot"
BUSYBOX="/data/adb/magisk/busybox"
ROOTFS="http://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.2-base-arm64.tar.gz"

mkdir $CHROOT
mkdir $CHROOT/sdcard
cd $CHROOT
$BUSYBOX wget $ROOTFS
$BUSYBOX tar -xvpf *.tar.gz 
rm *.tar.gz 
 
