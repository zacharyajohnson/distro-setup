#!/bin/sh

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set"
        exit 1
fi

dirname="$(dirname "$0")"
cp "$dirname"'/config/.gitconfig' "$HOME"
