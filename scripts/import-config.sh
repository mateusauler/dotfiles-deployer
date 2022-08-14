#!/bin/bash

cfg_dir=$HOME/.cfg
bkp_dir=.config-backup_$(date +"%Y-%m-%d_%H-%M-%S")
origin=$(realpath $(dirname -- "$0")/..)
base_address=$(cat $origin/res/base-address)

function g {
	/usr/bin/git --git-dir=$cfg_dir --work-tree=$HOME $@
}

function backup_file {
	parent_dir=$(dirname $1 | sed "s|^|$HOME/$bkp_dir/|")
	mkdir -p $parent_dir
	mv $1 $parent_dir
}

function log {
	echo
	echo $@
	echo
}

function cd_and_install {
	pushd $1 > /dev/null
	sudo make install
	sudo make clean
	popd > /dev/null
}

cd $origin
pushd $HOME > /dev/null

mkdir -p $bkp_dir

if [ -d $cfg_dir ]; then
	mv $cfg_dir $bkp_dir
fi

log "Backing up submodule directories..."
for f in $(curl https://raw.githubusercontent.com/mateusauler/dotfiles/master/.gitmodules | egrep "path\s*=\s*" | sed -E "s|path\s*=\s*||g")
do
	[ -e "$f" ] && backup_file "$f"
done

log "Cloning dotfiles repository..."
git clone --bare $base_address/dotfiles.git $cfg_dir
g checkout 2> /dev/null

if [ $? = 0 ]; then
	log "Checked out config.";
else
	log "Backing up pre-existing dot files...";
	for f in $(g checkout 2>&1 | egrep "\s+\." | awk {'print $1'})
	do
		backup_file "$f"
	done

	log "Checking out config..."
	g checkout
fi

g config status.showUntrackedFiles no

log "Cloning submodules..."
g submodule update --init --recursive

log "Removing unnecessary repository files..."
rm -f README.md LICENSE
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

for r in dwm st dmenu slock
do
	log "Installing $r..."
	cd_and_install $HOME/repos/$r
done

ln -f ~/pics/wall/$(cat $origin/res/wallpaper-name) ~/pics/wallpaper

log "Changing default shell..."
sudo chsh -s $(which fish) $USER
sudo chsh -s $(which fish)
