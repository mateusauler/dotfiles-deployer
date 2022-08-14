#!/bin/bash

# curl -Lks https://gist.githubusercontent.com/mateusauler/32658403d1495b92a1edfe47f2602c20/raw/ | /bin/bash

cfg_dir=$HOME/.cfg
bkp_dir=.config-backup

function g {
	/usr/bin/git --git-dir=$cfg_dir --work-tree=$HOME $@
}

cd ..
pushd $HOME

sudo pacman -S --needed --noconfirm git fish

mkdir -p $bkp_dir

if [ -d $cfg_dir ]; then
	mv $cfg_dir $bkp_dir
fi

git clone --recursive --bare https://github.com/mateusauler/dotfiles.git $cfg_dir

g checkout 2> /dev/null

if [ $? = 0 ]; then
	echo "Checked out config.";
else
	echo "Backing up pre-existing dot files.";
	for f in $(g checkout 2>&1 | egrep "\s+\." | awk {'print $1'})
	do
		parent_dir=$(dirname $f | sed "s|^|$HOME/$bkp_dir/|")
		mkdir -p $parent_dir
		mv $f $parent_dir
	done
fi;

echo "Checking out config..."
g checkout
g config status.showUntrackedFiles no

rm -f README.md
rm -f LICENSE
g update-index --assume-unchanged README.md LICENSE

rmdir $bkp_dir 2> /dev/null

chsh -s $(which fish)
sudo chsh -s $(which fish)

popd

chmod +x scripts/*.sh
scripts/install-paru.sh
scripts/install-pkgs.sh
scripts/clone-repos.sh
scripts/create-shortcuts.sh

function cd_and_install {
	pushd $1
	sudo make install clean
	popd
}

cd_and_install $HOME/repos/dwm
cd_and_install $HOME/repos/st
cd_and_install $HOME/repos/dmenu
cd_and_install $HOME/repos/slock
