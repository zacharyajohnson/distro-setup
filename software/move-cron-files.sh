#!/bin/sh

folder=$1
cron_folder='cron'
distro_config_cron_folder="$HOME/.distro-config/$cron_folder/$folder"

if [ -z "$folder" ]; then
        echo "Provide folder to look for cron files"
elif [ -d "$folder/$cron_folder" ]; then
        echo "Moving cron files for $folder to $distro_config_cron_folder"
        mkdir -p "$distro_config_cron_folder"
        cp -r "$folder/$cron_folder/." "$distro_config_cron_folder"
fi


