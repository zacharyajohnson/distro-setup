#!/bin/sh

printf 'Would you like to install:\n    (1/Default)IntelliJ Community\n    (2)IntelliJ Ultimate\n'

read -r answer

if [ -z "$answer" ] || [ "$answer" -eq 1 ]; then
        printf 'Installing IntelliJ Community\n'
        sudo flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community
elif [ "$answer" -eq 2 ]; then
        printf 'Installing Intellij Ultimate\n'
        sudo flatpak install flathub com.jetbrains.IntelliJ-IDEA-Ultimate
else
        printf 'Invalid option. Aborting...\n'
        exit 1
fi

