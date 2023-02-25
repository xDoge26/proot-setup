#!/bin/bash

rm -rf ~/.wine
wget https://github.com/ThieuMinh26/Proot-Setup/releases/download/1.0/64bit-wine.tar.xz
tar -xvf 64bit-wine.tar.xz
echo 'alias gts=WINEDLLOVERRIDES="winegstreamer="' >> ~/.bashrc
source ~/.bashrc
clear

echo "If you have kernel32.dll problem , restart Termux"
echo "And please use : gst box86 wine winecfg"
echo "Or : rm -rf ~/.wine && WINEARCH=win32 box86 wine winecfg"

