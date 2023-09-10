#!/bin/sh

folder=$1

install_config_file='install-config.sh'

if [ -z "$folder" ]; then
        echo "Provide folder to look for config files"
elif [ -f "$folder/$install_config_file" ]; then
        echo "Installing config files for $folder"
        (
                cd "$folder" \
                        && "./$install_config_file"

        )
fi

