#!/bin/sh

folder=$1
distro_config_bin_folder="$HOME/.distro-config/bin"

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

if [ -z "$folder" ]; then
        echo "$0: Provide folder to look for bin scripts." >&2
        exit 1
elif [ -d "$folder/bin" ]; then
        echo "Installing bin scripts for $folder to $distro_config_bin_folder"
        mkdir -p "$distro_config_bin_folder"
        cp -r "$folder/bin/." "$distro_config_bin_folder"
else
        echo "Bin folder does not exist for $folder. Skipping..."
fi

