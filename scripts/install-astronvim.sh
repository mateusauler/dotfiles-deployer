#!/bin/bash

cfg_dir=${XDG_CONFIG_HOME:=~/.config}/nvim

paru -S --needed neovim astronvim neovide nerd-fonts-complete lazygit npm
paru -S --asdeps --needed python-neovim
paru -Rns --noconfirm powerline-vim powerline

if [ -e $cfg_dir/.git ] ;
then
	pushd $cfg_dir > /dev/null
	git pull
	popd > /dev/null
else
	if [ -e $cfg_dir ] ;
	then
		mv $cfg_dir $XDG_CONFIG_HOME/nvim-bkp
	fi

	git clone https://github.com/AstroNvim/AstroNvim $cfg_dir
fi

unset VIMINIT
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
sudo nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
