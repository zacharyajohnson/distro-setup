#!/bin/sh

dirname="$(dirname "$0")"

if [ -z "$HOME" ]; then
	echo "$0: HOME environment variable is not set" >&2
	exit 1
fi

cp -r "$dirname"/config/. "$HOME"
