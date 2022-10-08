#!/bin/sh

mkdir -p "$HOME/.vim" && cp -r config/* "$HOME/.vim" && sudo chown -R "$USER" "$HOME/.vim"
