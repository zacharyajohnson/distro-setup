#!/bin/sh

folder=$1
folder_name="$(basename "$folder")"
distro_config_alias_folder="$HOME/.distro-config/alias/$folder_name"

if [ -z "$HOME" ]; then
        echo "HOME environment variable is not set"
        exit 1
fi

if [ -z "$folder" ]; then
        echo "Provide folder to look for alias files."
elif [ -d "$folder/alias" ]; then
        echo "Installing alias files for $folder to $distro_config_alias_folder"
        mkdir -p "$distro_config_alias_folder"
        cp -r "$folder/alias/." "$distro_config_alias_folder"
fi
