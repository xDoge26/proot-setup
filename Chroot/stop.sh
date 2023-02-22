#!/data/data/com.termux/files/usr/bin/sh

umount umount -lvf ./chroot/dev/pts
umount umount -lvf ./chroot/dev
umount umount -lvf ./chroot/proc
umount umount -lvf ./chroot/sys
umount umount -lvf ./chroot/sdcard

