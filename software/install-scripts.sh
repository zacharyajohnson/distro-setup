#!/bin/sh

dirname="$(dirname "$0")"

distro_config_file="$dirname/../distro-config.sh"
if [ ! -e "$distro_config_file" ]; then
        echo "$0: $distro_config_file does not exist. Aborting..." >&2
        exit 1
fi
# shellcheck source=../distro-config.sh
. "$distro_config_file"

directory=$1
script_directory='script'

if [ -z "$directory" ]; then
        echo "$0: Provide directory to look for scripts." >&2
        exit 1
elif [ -d "$directory/$script_directory" ]; then
        echo "$0: Installing scripts for $directory to $DISTRO_SCRIPT_DIRECTORY"
        mkdir -p "$DISTRO_SCRIPT_DIRECTORY"
        cp -r "$directory/$script_directory/." "$DISTRO_SCRIPT_DIRECTORY"
else
        echo "$0: Script directory does not exist for $directory. Skipping..."
fi
