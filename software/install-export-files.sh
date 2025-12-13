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
directory_name="$(basename "$directory")"
export_directory='export'
directory_to_install_export_files_to="$DISTRO_EXPORT_DIRECTORY/$directory_name"

if [ -z "$directory" ]; then
        echo "$0: Provide directory to look for export files." >&2
        exit 1
elif [ -d "$directory/$export_directory" ]; then
        echo "$0: Installing export files for $directory to $directory_to_install_export_files_to"
        mkdir -p "$directory_to_install_export_files_to"
        cp -r "$directory/$export_directory/." "$directory_to_install_export_files_to"
else
        echo "$0: Export directory does not exist for $directory. Skipping..."
fi
