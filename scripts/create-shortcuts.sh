#!/bin/bash

origin=$(pwd)

pushd $HOME/.scripts
chmod +x *.sh

cat $origin/res/shorcuts | while read line ; do
	add_shortcut.sh $line
done

popd
