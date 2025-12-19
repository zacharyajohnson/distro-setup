#!/bin/sh

printf 'Would you like to install:\n    (1/Default)IntelliJ Community\n    (2)IntelliJ Ultimate\n'

read -r answer

if [ -z "$answer" ] || [ "$answer" = "1" ]; then
        printf 'Installing IntelliJ Community\n'
        flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak install --user flathub com.jetbrains.IntelliJ-IDEA-Community
elif [ "$answer" = "2" ]; then
        printf 'Installing Intellij Ultimate\n'
        flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak install --user flathub com.jetbrains.IntelliJ-IDEA-Ultimate
else
        printf 'Invalid option. Aborting...\n'
        exit 1
fi

