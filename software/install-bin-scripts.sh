#!/bin/sh

folder=$1
distro_config_bin_folder="$HOME/.distro-config/bin"

if [ -z "$HOME" ]; then
        echo "HOME environment variable is not set"
        exit 1
fi

if [ -z "$folder" ]; then
        echo "Provide folder to look for bin scripts."
elif [ -d "$folder/bin" ]; then
        echo "Installing bin scripts for $folder to $distro_config_bin_folder"
        mkdir -p "$distro_config_bin_folder"
        cp -r "$folder/bin/." "$distro_config_bin_folder"
fi

