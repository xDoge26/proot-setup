#!/data/data/com.termux/files/usr/bin/bash

# Setup termux
echo "allow-external-apps = true" >> ~/.termux/termux.properties 
echo "hide-soft-keyboard-on-startup = true" >> ~/.termux/termux.properties

pkg clean && termux-setup-storage && yes | pkg update &&
pkg install -y tsu nano wget pulseaudio && pkg clean || exit 

echo 'alias start="su -c ./start.sh"
alias stop="su -c ./stop.sh"
pulseaudio --verbose --start --exit-idle-time=-1 --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1"
alias ubuntu="proot-distro login ubuntu --shared-tmp --no-sysvipc"' > ~/.bashrc 

# Setup chroot path
CHROOT="/data/data/com.termux/files/home/chroot"
BUSYBOX="/data/adb/magisk/busybox"
ROOTFS="http://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.2-base-arm64.tar.gz"
TMPDIR="/data/data/com.termux/files/usr/tmp"

# Download Ubuntu rootfs
su --command rm -rf $CHROOT 
su --command mkdir $CHROOT 
su --command mkdir $CHROOT/sdcard 
su --command $BUSYBOX wget --directory-prefix $CHROOT $ROOTFS || exit 
su --command $BUSYBOX tar -xpf $CHROOT/*.tar.gz --directory $CHROOT || exit 
su --command rm $CHROOT/*.tar.gz 

# Setup 

echo '#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "127.0.0.1 localhost" > /etc/hosts

groupadd -g 3001 aid_bt
groupadd -g 3002 aid_bt_net
groupadd -g 3003 aid_inet
groupadd -g 3004 aid_net_raw
groupadd -g 3005 aid_admin

usermod -a -G 3003 root
usermod -a -G 3003 _apt
usermod -g 3003 _apt

echo "alias gl=\"MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT MESA_EXTENSION_OVERRIDE=\"GL_EXT_polygon_offset_clamp\" GALLIUM_DRIVER=virpipe WINEDEBUG=-all\"
alias zink=\"MESA_LOADER_DRIVER_OVERRIDE=zink TU_DEBUG=noconform MESA_VK_WSI_DEBUG=sw\"
alias vk=\"TU_DEBUG=noconform MESA_VK_WSI_DEBUG=sw\"
alias fexbash=\"FEXBash\"
alias fexcfg=\"FEXConfig\"
alias fex=\"FEXInterpreter\"" >> ~/.bashrc
echo "vncserver -kill :1" > ~/.bash_logout
chmod 777 /tmp
rm /test.sh' > ~/test.sh

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
umount -lv ./chroot/tmp' > ~/start.sh

echo '#!/bin/sh
umount -lv ./chroot/dev/pts
umount -lv ./chroot/dev
umount -lv ./chroot/sys
umount -lv ./chroot/proc
umount -lv ./chroot/sdcard
umount -lv ./chroot/tmp' > ~/stop.sh

chmod 777 ~/start.sh ~/stop.sh ~/test.sh
su --command mv test.sh $CHROOT

# Enter chroot

su --command mount --bind /proc $CHROOT/proc
su --command mount --bind /sys $CHROOT/sys
su --command mount --bind /dev $CHROOT/dev
su --command mount --bind /dev/pts $CHROOT/dev/pts
su --command mount --bind /sdcard $CHROOT/sdcard
su --command mount --bind $TMPDIR $CHROOT/tmp

su --command chroot $CHROOT /bin/su - root -c "/test.sh"

su --command umount -lv $CHROOT/dev/pts
su --command umount -lv $CHROOT/dev
su --command umount -lv $CHROOT/sys
su --command umount -lv $CHROOT/proc
su --command umount -lv $CHROOT/sdcard
su --command umount -lv $CHROOT/tmp



