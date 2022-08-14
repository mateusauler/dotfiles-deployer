#!/bin/bash

cd $HOME

sudo pacman -S --noconfirm --needed base-devel

git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -sri

cd ..
rm -rf paru-bin