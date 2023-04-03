#!/bin/sh

sudo mkdir chroot
cd chroot 
sudo wget http://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.2-base-arm64.tar.gz 
sudo tar -xvpf *.tar.gz && sudo rm *.tar.gz && clear &&
sudo mkdir sdcard 
