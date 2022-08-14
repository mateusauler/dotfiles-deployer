#!/bin/bash

base_address="https://github.com/mateusauler"
origin=$(realpath $(dirname -- "$0")/..)

function clone {
	dest=${2:-repos/$1}
	addr=$base_address/$1
	if [ -e $dest/.git ] ; then
		pushd $dest > /dev/null
		git pull
		popd
	else
		git clone $addr $dest
	fi
}

pushd $HOME > /dev/null

cat $origin/res/repos | while read line ; do
	clone $line
done

popd > /dev/null
