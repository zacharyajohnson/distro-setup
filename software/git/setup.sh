#!/bin/sh

#Install git
sudo $install_command git

# Copy git config file over
sudo cp config/.gitconfig $HOME
