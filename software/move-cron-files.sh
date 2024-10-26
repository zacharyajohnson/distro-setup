#!/bin/sh

folder=$1
folder_name="$(basename "$folder")"
cron_folder='cron'
distro_cron_folder="$HOME/.distro/$cron_folder/$folder_name"

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

if [ -z "$folder" ]; then
        echo "$0: Provide folder to look for cron files" >&2
        exit 1
elif [ -d "$folder/$cron_folder" ]; then
        echo "$0: Moving cron files for $folder to $distro_cron_folder"
        mkdir -p "$distro_cron_folder"
        cp -r "$folder/$cron_folder/." "$distro_cron_folder"
else
        echo "$0: Cron folder does not exist for $folder. Skipping..."
fi

