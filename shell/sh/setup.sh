#!/bin/sh

if [ -z "$HOME" ]; then
        echo "HOME environment variable is not set"
        exit 1
fi

if [ -f "$HOME/.profile" ]; then
       echo ".profile exists. Backing up at $HOME/.backup-profile"
       cp "$HOME/.profile" "$HOME/.backup-profile"
fi

# Copy .profile config file to home folder
echo "Overriding .profile at $HOME"

# shellcheck source=/dev/null
cat '../common/common-config.sh' > "$HOME/.profile" && . "$HOME/.profile"

