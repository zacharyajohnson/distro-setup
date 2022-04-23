#!/bin/sh

# Copy .bashrc and .bash_profile config files to home folder
echo "Installing .bashrc and .bash_profile at $HOME"

sudo cp .bashrc $HOME/.bashrc && sudo cp .bash_profile $HOME/.bash_profile \
        && . $HOME/.bash_profile
