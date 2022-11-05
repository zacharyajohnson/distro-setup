#!/bin/sh

if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

if [ -f "$HOME/.aliases.sh" ]; then
        . "$HOME/.aliases.sh"
fi
