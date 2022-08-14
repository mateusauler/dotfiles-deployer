#!/bin/bash

function clone {
	dest=${2:-repos/$1}
	git clone $1 $dest
}

origin=$(pwd)

pushd $HOME

cat $origin/res/repos | while read line ; do
	clone $line
done

popd
