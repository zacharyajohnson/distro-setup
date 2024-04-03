#!/bin/sh

folder=$1

install_config_file='install-config.sh'

if [ -z "$folder" ]; then
        echo "Provide folder to look for config files"
        exit 1
elif [ -f "$folder/$install_config_file" ]; then
        echo "Installing config files for $folder"
        "$folder/$install_config_file"
else
        echo "Config folder does not exist for $folder. Skipping..."
fi

