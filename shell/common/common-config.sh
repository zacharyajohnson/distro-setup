#!/bin/sh

# Set shell command line editing to vi mode(Starts you in input mode)
set -o vi

_is_on_path() {
        echo "$PATH" | grep -q "$1" > /dev/null 2>&1
        return $?
}

if [ -z "$HOME" ]; then
        echo "HOME environment variable is not set"
else
        distro_script_directory="$HOME/.distro/script"

        distro_export_directory="$HOME/.distro/export"
        common_export_file="$distro_export_directory/common-export.sh"

        distro_alias_directory="$HOME/.distro/alias"
        common_alias_file="$distro_alias_directory/common-alias.sh"

        # If the bin directory exists and is not on the PATH add it
        if [ -d "$distro_script_directory" ] && ! _is_on_path "$distro_script_directory"; then
                PATH="$distro_script_directory:$PATH"
        fi

        if [ -d "$distro_alias_directory" ]; then
                if [ -e "$common_alias_file" ]; then
                        # shellcheck source=/dev/null
                        . "$common_alias_file"
                fi

                # Keep this after the alias so the common
                # ones can get overriden by program specific values
                for alias_file in $(echo "$distro_alias_directory"/**/*alias.sh)
                do
                        if [ -e "$alias_file" ]; then
                                # shellcheck source=/dev/null
                                . "$alias_file"
                        fi
                done
        fi

        if [ -d "$distro_export_directory" ]; then
                if [ -e "$common_export_file" ]; then
                        # shellcheck source=/dev/null
                        . "$common_export_file"
                fi

                # Keep this after the exports so the common
                # ones can get overriden by program specific values
                for export_file in $(echo "$distro_export_directory"/**/*export.sh)
                do
                        if [ -e "$export_file" ]; then
                                # shellcheck source=/dev/null
                                . "$export_file"
                        fi
                done
        fi
fi
