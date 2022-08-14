#!/bin/bash

if [ "$USER" == "root" ] ; then
	echo "You shouldn't run this script as root."
	exit 1
fi

mkdir -p $HOME/repos
cd $HOME/repos

sudo pacman -S --needed --noconfirm git

git clone https://github.com/mateusauler/dotfiles-deployer
cd dotfiles-deployer
chmod +x scripts/import-config.sh
scripts/import-config.sh
