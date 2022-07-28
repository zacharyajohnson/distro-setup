#!/bin/sh

#Copy over aliases common across all shells
cp '../common/.aliases.sh' "$HOME"

# Copy .bashrc and .bash_profile config files to home folder
echo "Installing .bashrc and .bash_profile at $HOME"

cp .bashrc "$HOME/.bashrc" && cp .bash_profile "$HOME/.bash_profile" \
        && . "$HOME/.bash_profile"
