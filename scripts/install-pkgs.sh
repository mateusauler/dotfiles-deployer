#!/bin/bash

pkgs=$(realpath $(dirname -- "$0")/..)/res/pkgs

function log {
	echo
	echo $@
	echo
}

log "Installing first packages..."
cat $pkgs-first | paru -S --needed --noconfirm -

log "Installing dependency packages..."
cat $pkgs-deps | paru -S --needed --noconfirm --asdeps -

log "Installing other packages..."
cat $pkgs | paru -S --needed --noconfirm -
