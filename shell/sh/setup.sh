#!/bin/sh

if [ -z "$HOME" ]; then
        echo "$0: HOME environment variable is not set" >&2
        exit 1
fi

distro_backup_folder="$HOME/.distro/backup/sh"
mkdir -p "$distro_backup_folder"

timestamp=$(date "+%Y-%m-%d-%H%M%S")

if [ -z "$timestamp" ]; then
        echo "$0: Could not generate timestamp using date command" >&2
        exit 1
fi


if [ -f "$HOME/.profile" ]; then
       echo ".profile exists. Backing up at $distro_backup_folder"
       cp "$HOME/.profile" "$distro_backup_folder/.backup-profile-$timestamp"
fi

# Copy .profile config file to home folder
echo "Overriding .profile at $HOME"

dirname="$(dirname "$0")"

common_config="$dirname"'/../common/common-config.sh'
if [ ! -e "$common_config" ]; then
        echo "$0: $common_config does not exist. Aborting..." >&2
        exit 1
fi

# shellcheck source=/dev/null
cat "$common_config" > "$HOME/.profile" && . "$HOME/.profile"

exit 0
