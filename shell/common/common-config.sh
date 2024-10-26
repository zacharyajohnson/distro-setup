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
        script_directory="$HOME/.distro-config/script"

        export_directory="$HOME/.distro-config/export"
        common_export_file="$export_directory/common-export.sh"

        alias_directory="$HOME/.distro-config/alias"
        common_alias_file="$alias_directory/common-alias.sh"

        # If the bin directory exists and is not on the PATH add it
        if [ -d "$script_directory" ] && ! _is_on_path "$script_directory"; then
                PATH="$script_directory:$PATH"
        fi

        if [ -d "$alias_directory" ]; then
                if [ -e "$common_alias_file" ]; then
                        # shellcheck source=/dev/null
                        . "$common_alias_file"
                fi

                # Keep this after the alias so the common
                # ones can get overriden by program specific values
                for alias_file in $(echo "$alias_directory"/**/*alias.sh)
                do
                        if [ -e "$alias_file" ]; then
                                # shellcheck source=/dev/null
                                . "$alias_file"
                        fi
                done
        fi

        if [ -d "$export_directory" ]; then
                if [ -e "$common_export_file" ]; then
                        # shellcheck source=/dev/null
                        . "$common_export_file"
                fi

                # Keep this after the exports so the common
                # ones can get overriden by program specific values
                for export_file in $(echo "$export_directory"/**/*export.sh)
                do
                        if [ -e "$export_file" ]; then
                                # shellcheck source=/dev/null
                                . "$export_file"
                        fi
                done
        fi
fi
