#!/bin/sh

directory=$1

install_config_file='install-config.sh'

if [ -z "$directory" ]; then
        printf '%s: Provide directory to look for config files\n' "$0" >&2
        exit 1
elif [ -f "$directory/$install_config_file" ]; then
        echo "Installing config files for $directory"
        "$directory/$install_config_file"
else
        echo "Config directory does not exist for $directory. Skipping..."
fi

