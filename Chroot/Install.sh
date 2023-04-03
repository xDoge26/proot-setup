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
 
echo 'chmod 1777 /tmp
echo "vncserver -kill :1" > ~/.bash_logout
echo "alias gl=\"MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT GALLIUM_DRIVER=virpipe WINEDEBUG=-all\"" >> ~/.bashrc
echo "alias zink=\"MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT GALLIUM_DRIVER=virpipe WINEDEBUG=-all\"" >> ~/.bashrc
source ~/.bashrc ' > $CHROOT/test.txt

