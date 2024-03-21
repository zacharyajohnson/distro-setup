#!/bin/sh

set -e

if [ -z "$HOME" ]; then
        echo "HOME environment variable is not set"
        exit 1
fi

if [ -f "$HOME/.bashrc" ]; then
       echo ".bashrc exists. Backing up at $HOME/.backup-bashrc"
       cp "$HOME/.bashrc" "$HOME/.backup-bashrc"
fi

if [ -f "$HOME/.bash_profile" ]; then
       echo ".bash_profile exists. Backing up at $HOME/.backup-bash-profile"
       cp "$HOME/.bash_profile" "$HOME/.backup-bash-profile"
fi

# Copy .bashrc and .bash_profile config files to home folder
echo "Overriding .bashrc and .bash_profile at $HOME"

cat '../common/common-config.sh' > "$HOME/.bashrc"

# shellcheck source=/dev/null
cp .bash_profile "$HOME/.bash_profile" \
        && . "$HOME/.bash_profile"
