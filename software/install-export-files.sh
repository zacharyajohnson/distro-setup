#!/bin/sh

folder=$1
distro_config_export_folder="$HOME/.distro-config/export/$folder"

if [ -z "$folder" ]; then
        echo "Provide folder to look for export files."
elif [ -d "$folder/export" ]; then
        echo "Installing export files for $folder to $distro_config_export_folder"
        mkdir -p "$distro_config_export_folder"
        cp -r "$folder/export/." "$distro_config_export_folder"
fi
