#!/bin/sh

folder=$1
folder_name="$(basename "$folder")"
distro_config_export_folder="$HOME/.distro-config/export/$folder_name"

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

if [ -z "$folder" ]; then
        echo "$0: Provide folder to look for export files." >&2
        exit 1
elif [ -d "$folder/export" ]; then
        echo "Installing export files for $folder to $distro_config_export_folder"
        mkdir -p "$distro_config_export_folder"
        cp -r "$folder/export/." "$distro_config_export_folder"
else
        echo "Export folder does not exist for $folder. Skipping..."
fi
