#!/bin/sh

folder=$1
folder_name="$(basename "$folder")"
alias_folder='alias'
distro_alias_folder="$HOME/.distro/$alias_folder/$folder_name"

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

if [ -z "$folder" ]; then
        echo "$0: Provide folder to look for alias files." >&2
        exit 1
elif [ -d "$folder/$alias_folder" ]; then
        echo "$0: Installing alias files for $folder to $distro_alias_folder"
        mkdir -p "$distro_alias_folder"
        cp -r "$folder/$alias_folder/." "$distro_alias_folder"
else
        echo "$0: Alias folder does not exist for $folder. Skipping..."
fi
