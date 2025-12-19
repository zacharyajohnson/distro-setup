#!/bin/sh

if [ "$#" -eq 0 ];then
        printf '%s usage: item-1 item-2 item-3 ...\n' "$0" >&2
        exit 1
fi

if [ -z "$HOME" ]; then
        printf '%s: HOME environment variable is not set\n' "$0" >&2
        exit 1
fi

timestamp=$(date "+%Y-%m-%d-%H%M%S")
if [ -z "$timestamp" ]; then
        printf '%s: Could not generate timestamp using date command\n' "$0" >&2
        exit 1
fi

trash_directory="$HOME/trash/$timestamp"

# "$@" expands each argument as a separate quoted word, preserving spaces in filenames
# It is important that $@ is surrounded by quotes or it will not handle items with
# spaces correctly
#
# Ex:
#       'Directory with Spaces'
#
#       Will be handled correctly with "$@" and will
#       be expanded to one directory
#
#       Will expand to three seperate directories with $@
#               Directory
#               with
#               Spaces
mkdir -p "$trash_directory" \
        && mv -i "$@" "$trash_directory"
