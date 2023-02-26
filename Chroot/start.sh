#!/data/data/com.termux/files/usr/bin/sh

# fix /data mount options
# mount -o remount,dev,suid /data

mount --bind /proc ./chroot/proc
mount --bind /sys ./chroot/sys
mount --bind /dev ./chroot/dev
mount --bind /dev/pts ./chroot/dev/pts
mount --bind /sdcard ./chroot/sdcard
# mount --bind /data/data/com.termux/files/usr/tmp ./chroot/tmp

# disable termux-exec
unset LD_PRELOAD

export PATH=/bin:/sbin:/usr/bin:/usr/sbin
export TERM=$TERM
export TMPDIR=/tmp

chroot ./chroot /bin/su - root

./stop.sh

