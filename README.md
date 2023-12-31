Setup Linux Proot/Chroot on Android with Pulse audio

## 1. Install ubuntu
#### 1.1 Proot ubuntu 
```
echo "allow-external-apps = true" >> ~/.termux/termux.properties && echo "hide-soft-keyboard-on-startup = true" >> ~/.termux/termux.properties
pkg clean && termux-setup-storage && yes | pkg update && pkg install nano wget proot-distro pulseaudio -y && pkg clean && proot-distro install ubuntu && proot-distro clear-cache &&
echo 'pulseaudio --verbose --start --exit-idle-time=-1 --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1"
alias start="proot-distro login ubuntu --shared-tmp --no-sysvipc"' >> ~/.bashrc && . ~/.bashrc && termux-reload-settings
```
#### 1.2 Chroot ubuntu 
```
su -c /data/adb/magisk/busybox wget https://github.com/xDoge26/proot-setup/raw/main/Chroot/Test_install.sh ; bash ./Test_install.sh ; . ~/.bashrc ; su -c rm ./Test_install.sh
```
## 2. Install xfce
```
wget https://github.com/xDoge26/proot-setup/raw/main/xfce4.sh ; bash xfce4.sh ; rm xfce4.sh
```

## 4. VirGL
- Creating alias
```
echo 'alias zink="MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT MESA_GLES_VERSION_OVERRIDE=3.2 GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy virgl_test_server --use-egl-surfaceless --use-gles &"' >> ~/.bashrc
source ~/.bashrc
```


