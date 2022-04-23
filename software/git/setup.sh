#!/bin/sh

#Install git
$install_command git

# Copy git config file over
cp config/.gitconfig $HOME
