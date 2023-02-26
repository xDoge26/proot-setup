#!/bin/bash

cd
rm -rf ~/.wine
rm -rf ~/wine-8.0.tar.xz
wget https://github.com/ThieuMinh26/Proot-Setup/releases/download/1.0.0/wine-8.0.tar.xz
tar -xf wine-8.0.tar.xz
echo 'alias gst="WINEDLLOVERRIDES=\"winegstreamer=\""' >> ~/.bashrc
source ~/.bashrc
clear

echo "If you have kernel32.dll problem , restart Termux"
echo "Try : gst box86 wine winecfg"
echo "Or : WINEDLLOVERRIDES=\"winegstreamer=\" box86 wine winecfg"
echo "Or : rm -rf ~/.wine && WINEARCH=win32 box86 wine winecfg"

