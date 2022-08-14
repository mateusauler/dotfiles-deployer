#!/bin/bash

if [ "$USER" == "root" ] ; then
	echo "You shouldn't run this script as root." 1>&2
	exit 1
fi

repo_name=dotfiles-deployer
dirname=$HOME/repos/$repo_name

sudo pacman -S --needed --noconfirm git

mkdir -p $dirname
cd $dirname

if [ -e .git ] ; then
	git pull
else
	git clone https://github.com/mateusauler/$repo_name $dirname
fi

chmod +x scripts/import-config.sh
scripts/import-config.sh
