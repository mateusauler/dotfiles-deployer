#!/bin/bash

$(command -v paru &> /dev/null) && exit

dir=$HOME/paru-bin

echo
echo "Installing paru..."
echo

sudo pacman -S --noconfirm --needed base-devel

git clone https://aur.archlinux.org/paru-bin.git $dir
cd $dir
makepkg -sri --noconfirm --needed

rm -rf $dir
