#!/bin/sh

folder=$1
folder_name="$(basename "$folder")"
export_folder='export'
distro_export_folder="$HOME/.distro/$export_folder/$folder_name"

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

if [ -z "$folder" ]; then
        echo "$0: Provide folder to look for export files." >&2
        exit 1
elif [ -d "$folder/$export_folder" ]; then
        echo "$0: Installing export files for $folder to $distro_export_folder"
        mkdir -p "$distro_export_folder"
        cp -r "$folder/$export_folder/." "$distro_export_folder"
else
        echo "$0: Export folder does not exist for $folder. Skipping..."
fi
