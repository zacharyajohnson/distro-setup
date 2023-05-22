#!/bin/sh

# Python-gpgme is a hard dependency for dropbox in arch for some reason
sudo pacman -S python-gpgme

curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/dropbox.tar.gz
tar -xvf dropbox.tar.gz
rm -rf dropbox.tar.gz

cd dropbox/
makepkg -si

cd ../
rm -rf dropbox/
