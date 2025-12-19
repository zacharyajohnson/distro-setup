#!/bin/sh

dirname="$(dirname "$0")"

if [ -z "$HOME" ]; then
	echo "$0: HOME environment variable is not set" >&2
	exit 1
fi

mkdir -p "$HOME/.vim"

# Copy config files only if the config directory exists and is non-empty
# -d checks if directory exists
# ls -A lists all files (including hidden), excluding . and ..
# -n checks if ls output is non-empty
# 2>/dev/null suppresses error messages if directory doesn't exist
if [ -d "$dirname/config" ] && [ -n "$(ls -A "$dirname/config" 2>/dev/null)" ]; then
	cp -r "$dirname"/config/* "$HOME/.vim"
fi
