#!/bin/sh

# Set shell command line editing to vi mode(Starts you in input mode)
set -o vi

_is_on_path() {
        echo "$PATH" | grep -q "$1" > /dev/null 2>&1
        return $?
}

# Source bootstrap file to find distro base directory
distro_bootstrap_file="$HOME/.distro-bootstrap"
if [ -e "$distro_bootstrap_file" ]; then
        # shellcheck source=/dev/null
        . "$distro_bootstrap_file"
else
        echo "Warning: $distro_bootstrap_file not found. Using default location."
        DISTRO_BASE_DIRECTORY="$HOME/.distro"
fi

# Source full distro configuration
distro_config_file="$DISTRO_BASE_DIRECTORY/distro-config.sh"
if [ -e "$distro_config_file" ]; then
        # shellcheck source=/dev/null
        . "$distro_config_file"
else
        echo "Warning: $distro_config_file not found. Using defaults."
        DISTRO_SCRIPT_DIRECTORY="$DISTRO_BASE_DIRECTORY/script"
        DISTRO_EXPORT_DIRECTORY="$DISTRO_BASE_DIRECTORY/export"
        DISTRO_ALIAS_DIRECTORY="$DISTRO_BASE_DIRECTORY/alias"
fi

common_export_file="$DISTRO_EXPORT_DIRECTORY/common-export.sh"
common_alias_file="$DISTRO_ALIAS_DIRECTORY/common-alias.sh"

user_local_bin_directory="$HOME/.local/bin"

if [ -d "$user_local_bin_directory" ] &&  ! _is_on_path "$user_local_bin_directory"; then
        PATH="$user_local_bin_directory:$PATH"
fi

# If the script directory exists and is not on the PATH add it
if [ -d "$DISTRO_SCRIPT_DIRECTORY" ] && ! _is_on_path "$DISTRO_SCRIPT_DIRECTORY"; then
        PATH="$DISTRO_SCRIPT_DIRECTORY:$PATH"
fi

if [ -d "$DISTRO_ALIAS_DIRECTORY" ]; then
        if [ -e "$common_alias_file" ]; then
                # shellcheck source=/dev/null
                . "$common_alias_file"
        fi

        # Keep this after the alias so the common
        # ones can get overriden by program specific values
        for alias_file in $(echo "$DISTRO_ALIAS_DIRECTORY"/**/*alias.sh)
        do
                if [ -e "$alias_file" ]; then
                        # shellcheck source=/dev/null
                        . "$alias_file"
                fi
        done
fi

if [ -d "$DISTRO_EXPORT_DIRECTORY" ]; then
        if [ -e "$common_export_file" ]; then
                # shellcheck source=/dev/null
                . "$common_export_file"
        fi

        # Keep this after the exports so the common
        # ones can get overriden by program specific values
        for export_file in $(echo "$DISTRO_EXPORT_DIRECTORY"/**/*export.sh)
        do
                if [ -e "$export_file" ]; then
                        # shellcheck source=/dev/null
                        . "$export_file"
                fi
        done
fi
