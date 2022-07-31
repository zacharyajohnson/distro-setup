#!/bin/sh

$install_command vim

# move vim config files to $HOME/.vim
mkdir -p "$HOME/.vim" && cp -r config/* "$HOME/.vim" && sudo chown -R "$USER" "$HOME/.vim"
