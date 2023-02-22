#!/data/data/com.termux/files/usr/bin/sh

# fix /data mount options
# mount -o remount,dev,suid /data
# mount --bind /data/data/com.termux/files/usr/tmp ./chroot/tmp

mount --bind /proc ./chroot/proc
mount --bind /sys ./chroot/sys
mount --bind /dev ./chroot/dev
mount --bind /dev/pts ./chroot/dev/pts
mount --bind /sdcard ./chroot/sdcard

# disable termux-exec
unset LD_PRELOAD

export PATH=/bin:/sbin:/usr/bin:/usr/sbin
export TERM=$TERM
export TMPDIR=/tmp

chroot ./chroot /bin/su - root

umount -lvf ./chroot/dev/pts
umount -lvf ./chroot/dev
umount -lvf ./chroot/sys
umount -lvf ./chroot/proc
umount -lvf ./chroot/sdcard
