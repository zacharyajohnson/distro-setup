#!/bin/sh

#Install git
$install_command git

# Copy git config file over
sudo cp config/.gitconfig $HOME
