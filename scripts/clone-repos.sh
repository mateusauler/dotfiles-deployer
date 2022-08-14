#!/bin/bash

origin=$(realpath $(dirname -- "$0")/..)
base_address=$(cat $origin/res/base-address)

function clone {
	echo "Cloning $1..."

	dest=${2:-repos/$1}
	addr=$base_address/$1
	if [ -e $dest/.git ] ; then
		pushd $dest > /dev/null
		git pull
		popd > /dev/null
	else
		git clone $addr $dest
	fi

	echo
}

echo
echo "Cloning repos..."
echo

pushd $HOME > /dev/null

cat $origin/res/repos | while read line ; do
	clone $line
done

popd > /dev/null
