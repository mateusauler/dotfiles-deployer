#!/bin/bash

cfg_dir=$HOME/.cfg
bkp_dir=.config-backup_$(date +"%Y-%m-%d_%H-%M-%S")
origin=$(realpath $(dirname -- "$0")/..)
base_address=$(cat $origin/res/base-address)

function g {
	/usr/bin/git --git-dir=$cfg_dir --work-tree=$HOME $@
}

cd $origin
pushd $HOME > /dev/null

mkdir -p $bkp_dir

if [ -d $cfg_dir ]; then
	mv $cfg_dir $bkp_dir
fi

git clone --bare $base_address/dotfiles.git $cfg_dir

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

g submodule update --init --recursive

rm -f README.md
rm -f LICENSE
g update-index --assume-unchanged README.md LICENSE

rmdir $bkp_dir 2> /dev/null

popd > /dev/null

chmod +x scripts/*.sh
scripts/install-paru.sh &&
scripts/install-pkgs.sh &&
scripts/clone-repos.sh &&
scripts/create-shortcuts.sh &&
scripts/install-astronvim.sh ||
exit 1

function cd_and_install {
	pushd $1 > /dev/null
	sudo make install clean
	popd > /dev/null
}

for r in "dwm st dmenu slock"
do
	cd_and_install $HOME/repos/$r
done

sudo chsh -s $(which fish) $USER
sudo chsh -s $(which fish)
