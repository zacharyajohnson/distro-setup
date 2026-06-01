#!/bin/sh

printf 'Installing Discord\n'

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install --user discord 
