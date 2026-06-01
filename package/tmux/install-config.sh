#!/bin/sh

dirname="$(dirname "$0")"

if [ -z "$HOME" ]; then
	printf '%s: HOME environment variable is not set\n' "$0" >&2
	exit 1
fi

cp -r "$dirname"/config/. "$HOME"
