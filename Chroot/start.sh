#!/data/data/com.termux/files/usr/bin/sh

mount --bind /proc ./chroot/proc
mount --bind /sys ./chroot/sys
mount --bind /dev ./chroot/dev
mount --bind /dev/pts ./chroot/dev/pts
mount --bind /sdcard ./chroot/sdcard
# mount --bind /data/data/com.termux/files/usr/tmp ./chroot/tmp
# mount --bind /data/data/com.mittorn.virgloverlay/files/ ./chroot/tmp


# disable termux-exec
unset LD_PRELOAD

export PATH=/bin:/sbin:/usr/bin:/usr/sbin
export TERM=$TERM
export TMPDIR=/tmp

chroot ./chroot /bin/su - root

./stop.sh

