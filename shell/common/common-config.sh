#!/bin/sh

bin_directory="$HOME/bin"

export_directory="$HOME/.export"
common_export_file="$export_directory/common-export.sh"

alias_directory="$HOME/.alias"
common_alias_file="$alias_directory/common-alias.sh"

if [ -d "$bin_directory" ]; then
	PATH="$bin_directory:$PATH"
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


