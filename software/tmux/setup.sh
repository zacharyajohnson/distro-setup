#!/bin/sh

# Install tmux
$install_command tmux

#Copy tmux config file over
cp config/.tmux.conf "$HOME"

# Move config files for custom tmux setups to the bin folder so they can be executed anywhere
cp bin/* "$HOME/bin"
