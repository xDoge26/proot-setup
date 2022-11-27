#!/bin/bash

dpkg --add-architecture armhf

apt update && apt upgrade -y

apt-get install sudo wget nano tigervnc-standalone-server dbus-x11 -y

apt-get install xfce4 xfce4-terminal --no-install-recommends -y

apt install tango-icon-theme
update-icon-caches /usr/share/icons/*

apt clean && apt autoremove -y

mkdir ~/.vnc
wget https://raw.githubusercontent.com/Techriz/AndronixOrigin/master/APT/XFCE4/xstartup -P ~/.vnc/
wget https://raw.githubusercontent.com/Techriz/AndronixOrigin/master/APT/XFCE4/vncserver-start -P /usr/local/bin/
wget https://raw.githubusercontent.com/Techriz/AndronixOrigin/master/APT/XFCE4/vncserver-stop -P /usr/local/bin/
chmod +x /usr/local/bin/vncserver-start
chmod +x /usr/local/bin/vncserver-stop
chmod +x ~/.vnc/xstartup

echo "export DISPLAY=":1"" >> /etc/profile
source /etc/profile

echo "vncserver -name remote-desktop -geometry 960x540 :1" > /usr/local/bin/vncserver-start

echo -e "vncserver -kill :1\nrm -rf /root/.vnc/localhost:1.pid\nrm -rf /tmp/.X1-lock\nrm -rf /tmp/.X11-unix/X1" > ~/.bash_logout

vncpasswd
vncserver-start
