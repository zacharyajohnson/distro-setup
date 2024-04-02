#!/bin/sh

(
        cd '/tmp' || exit

        curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/dropbox.tar.gz
        tar -xvf dropbox.tar.gz

        cd dropbox/
        makepkg -si
)

