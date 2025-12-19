#!/bin/sh

dirname="$(dirname "$0")"

distro_config_file="$dirname/../distro-config.sh"
if [ ! -e "$distro_config_file" ]; then
        printf '%s: %s does not exist. Aborting...\n' "$0" "$distro_config_file" >&2
        exit 1
fi
# shellcheck source=../distro-config.sh
. "$distro_config_file"

directory=$1
directory_name="$(basename "$directory")"
cron_directory='cron'
directory_to_move_cron_files_to="$DISTRO_CRON_DIRECTORY/$directory_name"

if [ -z "$directory" ]; then
        printf '%s: Provide directory to look for cron files\n' "$0" >&2
        exit 1
elif [ -d "$directory/$cron_directory" ]; then
        echo "$0: Moving cron files for $directory to $directory_to_move_cron_files_to"
        mkdir -p "$directory_to_move_cron_files_to"
        cp -r "$directory/$cron_directory/." "$directory_to_move_cron_files_to"
else
        echo "$0: Cron directory does not exist for $directory. Skipping..."
fi
