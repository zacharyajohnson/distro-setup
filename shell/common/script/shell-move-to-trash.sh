#!/bin/sh

if [ "$#" -eq 0 ];then
        echo "$0 usage: item-1 item-2 item-3 ..." >&2
        exit 1
fi

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

timestamp=$(date "+%Y-%m-%d-%H%M%S")
if [ -z "$timestamp" ]; then
        echo "$0: Could not generate timestamp using date command" >&2
        exit 1
fi

trash_folder="$HOME/trash/$timestamp"

# "$@" expands each argument as a separate quoted word, preserving spaces in filenames
# It is important that $@ is surrounded by quotes or it will not handle items with
# spaces correctly
#
# Ex:
#       'Folder with Spaces'
#       
#       Will be handled correctly with "$@" and will
#       be expanded to one folder
#
#       Will expand to three seperate folders with $@
#               Folder
#               with
#               Spaces
mkdir -p "$trash_folder" \
        && mv -i "$@" "$trash_folder"
