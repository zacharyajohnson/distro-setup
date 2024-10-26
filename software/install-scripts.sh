#!/bin/sh

folder=$1
script_folder="$HOME/.distro-config/script"

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

if [ -z "$folder" ]; then
        echo "$0: Provide folder to look for bin scripts." >&2
        exit 1
elif [ -d "$folder/script" ]; then
        echo "Installing scripts for $folder to $script_folder"
        mkdir -p "$script_folder"
        cp -r "$folder/script/." "$script_folder"
else
        echo "Script folder does not exist for $folder. Skipping..."
fi

