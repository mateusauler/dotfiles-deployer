#!/bin/bash

if [ "$USER" == "root" ] ; then
	echo "You shouldn't run this script as root."
	exit 1
fi

sudo pacman -S --needed --noconfirm git

mkdir -p $HOME/repos
cd $HOME/repos

if [ -e dotfiles-deployer/.git ]
	cd dotfiles-deployer
	git pull
else
	git clone https://github.com/mateusauler/dotfiles-deployer
	cd dotfiles-deployer
fi

chmod +x scripts/import-config.sh
scripts/import-config.sh
