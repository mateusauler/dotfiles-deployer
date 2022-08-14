#!/bin/bash

if [ "$USER" == "root" ] ; then
	echo "You shouldn't run this script as root."
	exit 1
fi

repo_name=dotfiles-deployer

sudo pacman -S --needed --noconfirm git

mkdir -p $HOME/repos
cd $HOME/repos

if [ -e $repo_name/.git ]
	cd $repo_name
	git pull
else
	git clone https://github.com/mateusauler/$repo_name
	cd $repo_name
fi

chmod +x scripts/import-config.sh
scripts/import-config.sh
