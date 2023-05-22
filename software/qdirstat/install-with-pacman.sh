#!/bin/sh

sudo pacman -S qdirstat

curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/qdirstat.tar.gz

tar -xvf qdirstat.tar.gz
rm -rf qdirstat.tar.gz

cd qdirstat
makepkg -si qdirstat

cd ../
rm -rf qdirstat
