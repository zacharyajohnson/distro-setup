#!/bin/sh

if [ "$#" -eq 0 ];then
        echo "Usage: shell-move-to-trash item-1 item-2 item-3 ..."
        exit 1
fi

if [ -z "$HOME" ]; then
        echo "HOME environment variable is not set"
        exit 1
fi

timestamp=$(date "+%Y-%m-%d-%H%M%S")
if [ -z "$timestamp" ]; then
        echo "shell-move-to-trash: Could not generate timestamp using date command"
        exit 1
fi

trash_folder="$HOME/trash/$timestamp"

things_to_move="$*"

mkdir --parents "$trash_folder" \
        && mv --interactive $things_to_move "$trash_folder"
