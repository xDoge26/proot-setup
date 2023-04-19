#!/data/data/com.termux/files/usr/bin/bash

echo "allow-external-apps = true" >> ~/.termux/termux.properties 
echo "hide-soft-keyboard-on-startup = true" >> ~/.termux/termux.properties

pkg clean && termux-setup-storage && yes | pkg update &&
pkg install tsu nano wget pulseaudio -y && pkg clean &&

echo 'alias start="su -c ./start.sh"
alias stop="su -c ./stop.sh"
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
alias gl="MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT MESA_GLES_VERSION_OVERRIDE=3.2 virgl_test_server_android &"
alias zink="MESA_NO_ERROR=1 MESA_GL_VERSION_OVERRIDE=4.3COMPAT MESA_GLES_VERSION_OVERRIDE=3.2 GALLIUM_DRIVER=zink ZINK_DESCRIPTORS=lazy virgl_test_server --use-egl-surfaceless --use-gles &"' > ~/.bashrc 

source ~/.bashrc
