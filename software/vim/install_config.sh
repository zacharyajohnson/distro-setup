#!/bin/sh

mkdir -p "$HOME/.vim" && cp -r config/* "$HOME/.vim" && chown -R "$USER" "$HOME/.vim"
