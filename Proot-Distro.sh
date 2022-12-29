#!/bin/bash

apt update && apt upgrade -y

apt-get install sudo nano wget xfe dbus-x11 tigervnc-standalone-server -y

apt-get install xfce4 xfce4-terminal --no-install-recommends -y

apt install adwaita-icon-theme-full -y
apt install tango-icon-theme -y
apt install gnome-themes-extra -y
update-icon-caches /usr/share/icons/*

apt clean && apt autoremove -y

mkdir ~/.vnc

# wget https://raw.githubusercontent.com/Techriz/AndronixOrigin/master/APT/XFCE4/xstartup -P ~/.vnc/

echo '#!/bin/bash
xrdb $HOME/.Xresources
startxfce4' > ~/.vnc/xstartup

# wget https://raw.githubusercontent.com/Techriz/AndronixOrigin/master/APT/XFCE4/vncserver-start -P /usr/local/bin/

echo "vncserver -name remote-desktop -geometry 960x540 -localhost no :1" > /usr/local/bin/vncserver-start

# wget https://raw.githubusercontent.com/Techriz/AndronixOrigin/master/APT/XFCE4/vncserver-stop -P /usr/local/bin/
echo '#!/usr/bin/env bash

export USER=root
export HOME=/root

vncserver -kill :1
rm -rf /root/.vnc/localhost:1.pid
rm -rf /tmp/.X1-lock
rm -rf /tmp/.X11-unix/X1' > /usr/local/bin/vncserver-stop

chmod +x /usr/local/bin/vncserver-start
chmod +x /usr/local/bin/vncserver-stop
chmod +x ~/.vnc/xstartup

echo "export DISPLAY=":1"" >> /etc/profile
echo "export PULSE_SERVER=127.0.0.1" >> /etc/profile

source /etc/profile

# echo "vncserver -name remote-desktop -geometry 960x540 :1" > /usr/local/bin/vncserver-start
echo "vncserver -name remote-desktop -geometry 960x540 -localhost no :1" > /usr/local/bin/vncserver-start

echo -e "vncserver -kill :1\nrm -rf /root/.vnc/localhost:1.pid\nrm -rf /tmp/.X1-lock\nrm -rf /tmp/.X11-unix/X1" > ~/.bash_logout

vncpasswd
vncserver-start
