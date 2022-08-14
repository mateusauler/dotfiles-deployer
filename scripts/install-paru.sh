#!/bin/bash

[ command -v paru ] && exit

dir=$HOME/paru-bin

sudo pacman -S --noconfirm --needed base-devel

git clone https://aur.archlinux.org/paru-bin.git $dir
cd $dir
makepkg -sri --noconfirm --needed

rm -rf $dir
