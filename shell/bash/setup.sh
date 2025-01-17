#!/bin/sh

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

distro_backup_folder="$HOME/.distro/backup/bash"
mkdir -p "$distro_backup_folder"

timestamp=$(date "+%Y-%m-%d-%H%M%S")
if [ -z "$timestamp" ]; then
        echo "$0: Could not generate timestamp using date command" >&2
        exit 1
fi

if [ -f "$HOME/.bashrc" ]; then
       echo ".bashrc exists. Backing up at $distro_backup_folder"
       cp "$HOME/.bashrc" "$distro_backup_folder/.backup-bashrc-$timestamp"
fi

if [ -f "$HOME/.bash_profile" ]; then
       echo ".bash_profile exists. Backing up at $distro_backup_folder"
       cp "$HOME/.bash_profile" "$distro_backup_folder/.backup-bash-profile-$timestamp"
fi

# Copy .bashrc and .bash_profile config files to home folder
echo "Overriding .bashrc and .bash_profile at $HOME"
dirname="$(dirname "$0")"

common_config="$dirname"'/../common/common-config.sh'
if [ ! -e "$common_config" ]; then
        echo "$0: $common_config does not exist. Aborting..." >&2
        exit 1
fi
cat "$common_config" > "$HOME/.bashrc"

bash_profile="$dirname"'/.bash_profile'
if [ ! -e "$bash_profile" ]; then
        echo "$0: $bash_profile does not exist. Aborting..." >&2
        exit 1
fi

# shellcheck source=/dev/null
cp "$bash_profile" "$HOME/.bash_profile" \
        && . "$HOME/.bash_profile"

