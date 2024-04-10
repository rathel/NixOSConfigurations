#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash

set -xeuo pipefail

git pull

nix flake update

git add .
git commit -m "updating flake"
git push

sudo nixos-rebuild switch --flake .