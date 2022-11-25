# Setup Box86-64_Wine86-64

sudo dpkg --add-architecture armhf

sudo apt update && sudo apt upgrade

# Install related kits :

sudo apt install gpg -y

# sudo apt install build-essential git make cmake wget gcc-arm-linux-gnueabihf libc6:armhf 

# sudo apt install mesa*:armhf zenity*:armhf libasound*:armhf libstdc++6:armhf #box86_dependencies

# sudo apt install mesa* zenity* #box64_dependencies

# - these packages are needed for running box86/wine-i386 on a 64-bit RPiOS via multiarch
	
# sudo dpkg --add-architecture armhf && sudo apt-get update # enable multi-arch

# sudo apt-get install libasound2:armhf libc6:armhf libglib2.0-0:armhf libgphoto2-6:armhf libgphoto2-port12:armhf libgstreamer-plugins-base1.0-0:armhf libgstreamer1.0-0:armhf libldap-2.4-2:armhf libopenal1:armhf libpcap0.8:armhf libpulse0:armhf libsane1:armhf libudev1:armhf libusb-1.0-0:armhf libvkd3d1:armhf libx11-6:armhf libxext6:armhf libasound2-plugins:armhf ocl-icd-libopencl1:armhf libncurses6:armhf libncurses5:armhf libcap2-bin:armhf libcups2:armhf libdbus-1-3:armhf libfontconfig1:armhf libfreetype6:armhf libglu1-mesa:armhf libglu1:armhf libgnutls30:armhf libgssapi-krb5-2:armhf libkrb5-3:armhf libodbc1:armhf libosmesa6:armhf libsdl2-2.0-0:armhf libv4l-0:armhf libxcomposite1:armhf libxcursor1:armhf libxfixes3:armhf libxi6:armhf libxinerama1:armhf libxrandr2:armhf libxrender1:armhf libxxf86vm1 libc6:armhf libcap2-bin:armhf # to run wine-i386 through box86:armhf on aarch64

# - these packages are needed for running box64/wine-amd64 on RPiOS (box64 only runs on 64-bit OS's)
	
# sudo apt-get install libasound2:arm64 libc6:arm64 libglib2.0-0:arm64 libgphoto2-6:arm64 libgphoto2-port12:arm64 libgstreamer-plugins-base1.0-0:arm64 libgstreamer1.0-0:arm64 libldap-2.4-2:arm64 libopenal1:arm64 libpcap0.8:arm64 libpulse0:arm64 libsane1:arm64 libudev1:arm64 libunwind8:arm64 libusb-1.0-0:arm64 libvkd3d1:arm64 libx11-6:arm64 libxext6:arm64 ocl-icd-libopencl1:arm64 libasound2-plugins:arm64 libncurses6:arm64 libncurses5:arm64 libcups2:arm64 libdbus-1-3:arm64 libfontconfig1:arm64 libfreetype6:arm64 libglu1-mesa:arm64 libgnutls30:arm64 libgssapi-krb5-2:arm64 libjpeg62-turbo:arm64 libkrb5-3:arm64 libodbc1:arm64 libosmesa6:arm64 libsdl2-2.0-0:arm64 libv4l-0:arm64 libxcomposite1:arm64 libxcursor1:arm64 libxfixes3:arm64 libxi6:arm64 libxinerama1:arm64 libxrandr2:arm64 libxrender1:arm64 libxxf86vm1:arm64 libc6:arm64 libcap2-bin:arm64

# Clean

sudo apt clean && sudo apt autoremove

# Install Box86

sudo wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list

wget -O- https://ryanfortner.github.io/box86-debs/KEY.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/box86-debs-archive-keyring.gpg

sudo apt update && sudo apt install box86 -y

# Install Box64

sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list

wget -O- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/box64-debs-archive-keyring.gpg 

sudo apt update && sudo apt install box64 -y

# Wine-i386

cd 

mkdir wine

cd wine 

wget https://github.com/Kron4ek/Wine-Builds/releases/download/7.21/wine-7.21-x86.tar.xz

tar -xvf *.tar.xz

mv ~/wine/wine*/* ~/wine

rm -r wine*

cd

# Wine-amd64

cd 

mkdir wine64

cd wine64

wget https://github.com/Kron4ek/Wine-Builds/releases/download/7.21/wine-7.21-amd64.tar.xz

tar -xvf *.tar.xz

mv ~/wine64/wine*/* ~/wine64

rm -r wine*

cd

# Add these lines to your /etc/profile:

echo "export BOX86_PATH=~/wine/bin/
export BOX86_LD_LIBRARY_PATH=~/wine/lib/wine/i386-unix/:/lib/i386-linux-gnu/:/lib/arm-linux-gnueabihf/:/lib/aarch64-linux-gnu/
export BOX64_PATH=~/wine64/bin/
export BOX64_LD_LIBRARY_PATH=~/wine64/lib/wine/i386-unix/:~/wine64/lib/wine/x86_64-unix/:/lib/i386-linux-gnu/:/lib/x86_64-linux-gnu/:/lib/arm-linux-gnueabihf/:/lib/aarch64-linux-gnu/" >> /etc/profile

