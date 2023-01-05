#!/bin/bash

# Setup Box86-64_Wine86-64

sudo dpkg --add-architecture armhf

sudo apt update && sudo apt upgrade

# Install related kits :

sudo apt install gpg -y

# OpenGL

sudo apt install libgl1:armhf libgl1 -y

# - these packages are needed for running box86/wine-i386 on a 64-bit RPiOS via multiarch
	
sudo dpkg --add-architecture armhf && sudo apt-get update 

sudo apt install libasound2:armhf libc6:armhf libglib2.0-0:armhf libgphoto2-6:armhf libgphoto2-port12:armhf libgstreamer-plugins-base1.0-0:armhf libgstreamer1.0-0:armhf libpcap0.8:armhf libpulse0:armhf libsane1:armhf libudev1:armhf libusb-1.0-0:armhf libx11-6:armhf libxext6:armhf ocl-icd-libopencl1:armhf libasound2-plugins:armhf libncurses6:armhf libcap2-bin:armhf libcups2:armhf libdbus-1-3:armhf libfontconfig1:armhf libfreetype6:armhf libglu1-mesa:armhf libgnutls30:armhf libgssapi-krb5-2:armhf libkrb5-3:armhf libodbc1:armhf libosmesa6:armhf libsdl2-2.0-0:armhf libv4l-0:armhf libxcomposite1:armhf libxcursor1:armhf libxfixes3:armhf libxi6:armhf libxinerama1:armhf libxrandr2:armhf libxrender1:armhf libxxf86vm1:armhf -y

# - these packages are needed for running box64/wine-amd64 on RPiOS (box64 only runs on 64-bit OS's)
	
sudo apt install libasound2 libc6 libglib2.0-0 libgphoto2-6 libgphoto2-port12 libgstreamer-plugins-base1.0-0 libgstreamer1.0-0 libpcap0.8 libpulse0 libsane1 libudev1 libunwind8 libusb-1.0-0 libx11-6 libxext6 ocl-icd-libopencl1 libasound2-plugins libncurses6 libcap2-bin libcups2 libdbus-1-3 libfontconfig1 libfreetype6 libglu1-mesa libgnutls30 libgssapi-krb5-2 libjpeg8 libkrb5-3 libodbc1 libosmesa6 libsdl2-2.0-0 libv4l-0 libxcomposite1 libxcursor1 libxfixes3 libxi6 libxinerama1 libxrandr2 libxrender1 libxxf86vm1 -y


# Clean

sudo apt clean && sudo apt autoremove -y

# Install Box86

sudo wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list

wget -O- https://ryanfortner.github.io/box86-debs/KEY.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/box86-debs-archive-keyring.gpg

sudo apt update && sudo apt install box86 -y

# Install Box64

sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list

wget -O- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/box64-debs-archive-keyring.gpg 

sudo apt update && sudo apt install box64 -y

# Wine-amd64

cd 

mkdir wine

cd wine

wget https://github.com/Kron4ek/Wine-Builds/releases/download/7.22/wine-7.22-amd64.tar.xz

tar -xvf *.tar.xz

mv ~/wine/wine*/* ~/wine

rm -r wine*

cd

# Install symlinks
sudo ln -s ~/wine/bin/wine /usr/local/bin/wine
sudo ln -s ~/wine/bin/wine64 /usr/local/bin/wine64
sudo chmod +x /usr/local/bin/wine /usr/local/bin/wine64

clear
