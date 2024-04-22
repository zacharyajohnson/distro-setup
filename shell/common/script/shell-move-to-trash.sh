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

things_to_move="$*"

mkdir -p "$trash_folder" \
        && mv -i $things_to_move "$trash_folder"
