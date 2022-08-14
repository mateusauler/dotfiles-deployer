#!/bin/bash

base_address="https://github.com/mateusauler"

function clone {
	dest=${2:-repos/$1}
	git clone $base_address/$1 $dest
}

origin=$(pwd)

pushd $HOME > /dev/null

cat $origin/res/repos | while read line ; do
	clone $line
done

popd > /dev/null
