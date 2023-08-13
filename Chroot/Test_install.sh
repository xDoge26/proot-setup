#!/data/data/com.termux/files/usr/bin/bash
set +o histexpand

# Setup termux
echo "allow-external-apps = true" >> ~/.termux/termux.properties 
echo "hide-soft-keyboard-on-startup = true" >> ~/.termux/termux.properties

pkg clean && termux-setup-storage && yes | pkg update &&
pkg install -y tsu nano wget pulseaudio && pkg clean || exit 

echo 'alias start="su -c ./start.sh"
alias stop="su -c ./stop.sh"
pulseaudio --verbose --start --exit-idle-time=-1 --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1"
alias ubuntu="proot-distro login ubuntu --shared-tmp --no-sysvipc"' > ~/.bashrc 

# Setup environment variables
CHROOT="./chroot"
BUSYBOX="/data/adb/magisk/busybox"
ROOTFS="http://cdimage.ubuntu.com/ubuntu-base/releases/jammy/release/ubuntu-base-22.04.3-base-arm64.tar.gz"
TMPDIR="/data/data/com.termux/files/usr/tmp"

# Download Ubuntu rootfs
su -c $BUSYBOX rm -rf $CHROOT 
su -c $BUSYBOX mkdir $CHROOT 
su -c $BUSYBOX mkdir $CHROOT/sdcard 
su -c $BUSYBOX wget --directory-prefix $CHROOT $ROOTFS || exit 
su -c $BUSYBOX tar -xpf $CHROOT/*.tar.gz --directory $CHROOT || exit 
su -c $BUSYBOX rm $CHROOT/*.tar.gz 

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

echo "
alias fexbash=\"FEXBash\"
alias fexcfg=\"FEXConfig\"
alias fex=\"FEXInterpreter\"" >> ~/.bashrc
echo "vncserver -kill" > ~/.bash_logout
chmod 777 /tmp
rm /test.sh' > ~/test.sh

echo "#!/bin/sh
mount --bind /proc $CHROOT/proc
mount --bind /sys $CHROOT/sys
mount --bind /dev $CHROOT/dev
mount --bind /dev/pts $CHROOT/dev/pts
mount --bind /sdcard $CHROOT/sdcard
mount --bind $TMPDIR $CHROOT/tmp

chroot $CHROOT /bin/su - root -c \"/test.sh\"

umount -lv $CHROOT/dev/pts
umount -lv $CHROOT/dev
umount -lv $CHROOT/sys
umount -lv $CHROOT/proc
umount -lv $CHROOT/sdcard
umount -lv $CHROOT/tmp" > ~/start.sh

echo "#!/bin/sh
umount -lv $CHROOT/dev/pts
umount -lv $CHROOT/dev
umount -lv $CHROOT/sys
umount -lv $CHROOT/proc
umount -lv $CHROOT/sdcard
umount -lv $CHROOT/tmp" > ~/stop.sh

chmod 777 ~/start.sh ~/stop.sh ~/test.sh
su -c mv ~/test.sh $CHROOT
su -c ./start.sh
sed -i 's/ -c "\/test.sh"//g' ~/start.sh


