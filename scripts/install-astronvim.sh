#!/bin/bash

cfg_dir=${XDG_CONFIG_HOME:=~/.config}/nvim

if [ -e $cfg_dir/.git ] ;
then
	cd $cfg_dir
	git pull
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
