#!/bin/sh

distro_config_backup_folder="$HOME/.distro-config/backup/sh"
mkdir -p "$distro_config_backup_folder"

timestamp=$(date "+%Y-%m-%d-%H%M%S")

if [ -z "$HOME" ]; then
        echo "HOME environment variable is not set"
        exit 1
fi

if [ -f "$HOME/.profile" ]; then
       echo ".profile exists. Backing up at $distro_config_backup_folder"
       cp "$HOME/.profile" "$distro_config_backup_folder/.backup-profile-$timestamp"
fi

# Copy .profile config file to home folder
echo "Overriding .profile at $HOME"

# shellcheck source=/dev/null
cat '../common/common-config.sh' > "$HOME/.profile" && . "$HOME/.profile"

