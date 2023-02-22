#!/data/data/com.termux/files/usr/bin/sh

umount -lvf ./chroot/dev/pts
umount -lvf ./chroot/dev
umount -lvf ./chroot/proc
umount -lvf ./chroot/sys
umount -lvf ./chroot/sdcard

