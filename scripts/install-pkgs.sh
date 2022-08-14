#!/bin/bash

origin=$(realpath $(dirname -- "$0")/..)
cat $origin/res/pkgs | paru -S --needed --noconfirm -
