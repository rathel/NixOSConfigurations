#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash git

set -xu 

git pull

nix flake update

git add .
git commit -m "updating flake"
git push

sudo nixos-rebuild switch --flake .

read -p "Would you like to reboot? " answer
case "$answer" in 
	Yes|yes|y|Y)
		sudo reboot
		;;
	*)
		exit
		;;
esac
