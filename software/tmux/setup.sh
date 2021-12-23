#!/bin/sh

# Install tmux
sudo $install_command tmux

#Copy tmux config file over
sudo cp config/.tmux.conf $HOME

# Move config files for custom tmux setups to the bin folder so they can be executed anywhere
sudo cp bin/* $HOME/bin
