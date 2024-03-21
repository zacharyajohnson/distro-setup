#!/bin/sh

if [ -z "$HOME" ]; then
        echo "HOME environment variable is not set"
        exit 1
fi

cp config/.gitconfig "$HOME"
