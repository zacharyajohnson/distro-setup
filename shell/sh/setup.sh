#!/bin/sh

#Copy over aliases common across all shells
cp '../common/.aliases.sh' "$HOME"

# Copy over exports that are common across all shells
cp '../common/.export.sh' "$HOME"

# Copy profile config file to home folder
echo "Installing .profile at $HOME"

cp .profile "$HOME/.profile" \
        && . "$HOME/.profile"
