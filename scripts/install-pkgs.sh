#!/bin/bash

pkgs=$(realpath $(dirname -- "$0")/..)/res/pkgs
cat $pkgs-first | paru -S --needed --noconfirm -
cat $pkgs-deps  | paru -S --needed --noconfirm --asdeps -
cat $pkgs       | paru -S --needed --noconfirm -
