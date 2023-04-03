#!/bin/sh

CHROOT="/data/chroot"
BUSYBOX="/data/adb/magisk/busybox"
ROOTFS="http://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.2-base-arm64.tar.gz"
TERMUXTMP="/data/data/com.termux/files/usr/tmp"

mkdir $CHROOT
mkdir $CHROOT/sdcard
cd $CHROOT
$BUSYBOX wget $ROOTFS
$BUSYBOX tar -xvpf *.tar.gz 
rm *.tar.gz 
 
echo '#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "127.0.0.1 localhost" > /etc/hosts

groupadd -g 3001 aid_bt
groupadd -g 3002 aid_bt_net
groupadd -g 3003 aid_inet
groupadd -g 3004 aid_net_raw
groupadd -g 3005 aid_admin

usermod -a -G 3001,3002,3003,3004,3005 root
usermod -a -G 3003 _apt
usermod -g 3003 _apt

chmod 1777 /tmp
echo "vncserver -kill :1" > ~/.bash_logout
echo "alias gl=\"MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT GALLIUM_DRIVER=virpipe WINEDEBUG=-all\"" >> ~/.bashrc
echo "alias zink=\"MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT GALLIUM_DRIVER=virpipe WINEDEBUG=-all\"" >> ~/.bashrc
source ~/.bashrc' > $CHROOT/test.sh

chmod 777 $CHROOT/test.sh

mount --bind /proc $CHROOT/proc
mount --bind /sys $CHROOT/sys
mount --bind /dev $CHROOT/dev
mount --bind /dev/pts $CHROOT/dev/pts
mount --bind /sdcard $CHROOT/sdcard
mount --bind $TERMUXTMP $CHROOT/tmp

chroot $CHROOT /bin/su - root -c "./test.sh"

umount -lv $CHROOT/dev/pts
umount -lv $CHROOT/dev
umount -lv $CHROOT/sys
umount -lv $CHROOT/proc
umount -lv $CHROOT/sdcard
umount -lv $CHROOT/tmp

rm $CHROOT/test.sh

