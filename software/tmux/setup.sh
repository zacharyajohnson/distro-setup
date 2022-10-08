#!/bin/sh

# Install tmux
$install_command tmux

#Copy tmux config file over
./install_config.sh

# Move config files for custom tmux setups to the bin folder so they can be executed anywhere
./install_bin_scripts.sh
