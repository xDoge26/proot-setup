#!/system/bin/sh

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
umount -lv ./chroot/tmp
