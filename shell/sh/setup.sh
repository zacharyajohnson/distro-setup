#!/bin/sh

dirname="$(dirname "$0")"

distro_config_file="$dirname/../../distro-config.sh"
if [ ! -e "$distro_config_file" ]; then
        printf '%s: %s does not exist. Aborting...\n' "$0" "$distro_config_file" >&2
        exit 1
fi

# shellcheck source=../distro-config.sh
. "$distro_config_file"

shell_config_backup_directory="$DISTRO_BACKUP_DIRECTORY/sh"
mkdir -p "$shell_config_backup_directory"

timestamp=$(date "+%Y-%m-%d-%H%M%S")

if [ -z "$timestamp" ]; then
        printf '%s: Could not generate timestamp using date command\n' "$0" >&2
        exit 1
fi


if [ -f "$HOME/.profile" ]; then
       echo ".profile exists. Backing up at $shell_config_backup_directory"
       cp "$HOME/.profile" "$shell_config_backup_directory/.backup-profile-$timestamp"
fi

# Copy .profile config file to home directory
echo "Overriding .profile at $HOME"

common_config="$dirname"'/../common/common-config.sh'
if [ ! -e "$common_config" ]; then
        printf '%s: %s does not exist. Aborting...\n' "$0" "$common_config" >&2
        exit 1
fi

# shellcheck source=/dev/null
cat "$common_config" > "$HOME/.profile" && . "$HOME/.profile"
