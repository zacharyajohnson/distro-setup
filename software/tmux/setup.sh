#!/bin/sh

# Install tmux
$install_command tmux

#Copy tmux config file over
cp -r config/. "$HOME"

# Move config files for custom tmux setups to the bin folder so they can be executed anywhere
cp -r bin/. "$HOME/bin"
