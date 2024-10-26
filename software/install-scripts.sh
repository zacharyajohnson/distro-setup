#!/bin/sh

folder=$1
distro_config_bin_folder="$HOME/.distro-config/script"

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

if [ -z "$folder" ]; then
        echo "$0: Provide folder to look for bin scripts." >&2
        exit 1
elif [ -d "$folder/script" ]; then
        echo "Installing scripts for $folder to $distro_config_bin_folder"
        mkdir -p "$distro_config_bin_folder"
        cp -r "$folder/script/." "$distro_config_bin_folder"
else
        echo "Script folder does not exist for $folder. Skipping..."
fi

