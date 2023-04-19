#!/bin/sh

# HOME="/data/data/com.termux/files/home"
CHROOT="/data/data/com.termux/files/home/chroot"
BUSYBOX="/data/adb/magisk/busybox"
ROOTFS="http://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.2-base-arm64.tar.gz"
TERMUXTMP="/data/data/com.termux/files/usr/tmp"

# Download Ubuntu rootfs
rm $CHROOT > /dev/null 2&>1
mkdir $CHROOT > /dev/null 2>&1
mkdir $CHROOT/sdcard > /dev/null 2>&1
$BUSYBOX wget -P $CHROOT $ROOTFS || exit 
$BUSYBOX tar -xpf $CHROOT/*.tar.gz --directory $CHROOT || exit 
rm $CHROOT/*.tar.gz 

# Setup 

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

chmod 777 /tmp
echo "vncserver -kill :1" > ~/.bash_logout
echo "alias gl=\"MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT GALLIUM_DRIVER=virpipe WINEDEBUG=-all\"" >> ~/.bashrc
echo "alias zink=\"MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT GALLIUM_DRIVER=virpipe WINEDEBUG=-all\"" >> ~/.bashrc
source ~/.bashrc' > $CHROOT/test.sh

chmod 777 $CHROOT/test.sh

# Create shortcut

echo '#!/bin/sh
mount --bind /proc ./chroot/proc
mount --bind /sys ./chroot/sys
mount --bind /dev ./chroot/dev
mount --bind /dev/pts ./chroot/dev/pts
mount --bind /sdcard ./chroot/sdcard
mount --bind /data/data/com.termux/files/usr/tmp ./chroot/tmp

chroot ./chroot /bin/su - root

umount -lv ./chroot/dev/pts
umount -lv ./chroot/dev
umount -lv ./chroot/sys
umount -lv ./chroot/proc
umount -lv ./chroot/sdcard
umount -lv ./chroot/tmp' > $HOME/start.sh

echo '#!/bin/sh
umount -lv ./chroot/dev/pts
umount -lv ./chroot/dev
umount -lv ./chroot/sys
umount -lv ./chroot/proc
umount -lv ./chroot/sdcard
umount -lv ./chroot/tmp' > $HOME/stop.sh

chmod -x $HOME/*.sh

# Enter chroot

mount --bind /proc $CHROOT/proc
mount --bind /sys $CHROOT/sys
mount --bind /dev $CHROOT/dev
mount --bind /dev/pts $CHROOT/dev/pts
mount --bind /sdcard $CHROOT/sdcard
mount --bind $TERMUXTMP $CHROOT/tmp

chroot $CHROOT /bin/su - root -c "/test.sh"

umount -lv $CHROOT/dev/pts
umount -lv $CHROOT/dev
umount -lv $CHROOT/sys
umount -lv $CHROOT/proc
umount -lv $CHROOT/sdcard
umount -lv $CHROOT/tmp

rm $CHROOT/test.sh

