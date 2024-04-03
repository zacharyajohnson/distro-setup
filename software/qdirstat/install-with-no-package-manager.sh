#!/bin/sh
(
        cd '/tmp' || exit
        curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/qdirstat.tar.gz

        tar -xvf qdirstat.tar.gz

        cd qdirstat || exit
        makepkg -si qdirstat
)

