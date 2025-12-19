#!/bin/sh

_is_on_path() {
        echo "$PATH" | grep -q "$1" 2>&1
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

        # Note: We use a here-document instead of a pipe to avoid subshell issues.
        # Piping to while (find | while read) creates a subshell, which means any
        # sourced aliases would be lost when the subshell exits. Using a here-document
        # ensures the while loop runs in the current shell.

        # IFS= sets IFS to empty string, disabling field splitting and preserving
        # leading/trailing whitespace in paths (defensive programming)
        while IFS= read -r alias_file; do
                # -n checks for non-empty lines (find output may have trailing newlines)
                if [ -n "$alias_file" ] && [ -e "$alias_file" ]; then
                        # shellcheck source=/dev/null
                        . "$alias_file"
                fi
        done << EOF
$(find "$DISTRO_ALIAS_DIRECTORY" -name "*alias.sh")
EOF
fi

if [ -d "$DISTRO_EXPORT_DIRECTORY" ]; then
        if [ -e "$common_export_file" ]; then
                # shellcheck source=/dev/null
                . "$common_export_file"
        fi

        # Keep this after the exports so the common
        # ones can get overriden by program specific values

        # Note: We use a here-document instead of a pipe to avoid subshell issues.
        # Piping to while (find | while read) creates a subshell, which means any
        # sourced aliases would be lost when the subshell exits. Using a here-document
        # ensures the while loop runs in the current shell.

        # IFS= sets IFS to empty string, disabling field splitting and preserving
        # leading/trailing whitespace in paths (defensive programming)
        while IFS= read -r export_file; do
                # -n checks for non-empty lines (find output may have trailing newlines)
                if [ -n "$export_file" ] && [ -e "$export_file" ]; then
                        # shellcheck source=/dev/null
                        . "$export_file"
                fi
        done << EOF
$(find "$DISTRO_EXPORT_DIRECTORY" -name "*export.sh")
EOF
fi
