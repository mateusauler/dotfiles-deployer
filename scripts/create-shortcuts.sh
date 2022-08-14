#!/bin/bash

origin=$(realpath $(dirname -- "$0")/..)

echo
echo "Linking shortcuts..."
echo

pushd $HOME/.scripts > /dev/null
chmod +x *.sh

cat $origin/res/shortcuts | while read line ; do
	./add_shortcut.sh $line
done

popd > /dev/null
