#!/bin/sh

dirname="$(dirname "$0")"

mkdir -p "$HOME/.vim" && cp -r "$dirname"/config/* "$HOME/.vim"
