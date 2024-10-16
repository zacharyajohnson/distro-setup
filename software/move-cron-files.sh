#!/bin/sh

folder=$1
folder_name="$(basename "$folder")"
cron_folder='cron'
distro_config_cron_folder="$HOME/.distro-config/$cron_folder/$folder_name"

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

if [ -z "$folder" ]; then
        echo "$0: Provide folder to look for cron files" >&2
        exit 1
elif [ -d "$folder/$cron_folder" ]; then
        echo "Moving cron files for $folder to $distro_config_cron_folder"
        mkdir -p "$distro_config_cron_folder"
        cp -r "$folder/$cron_folder/." "$distro_config_cron_folder"
else
        echo "Cron folder does not exist for $folder. Skipping..."
fi

