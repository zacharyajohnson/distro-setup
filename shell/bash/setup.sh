#!/bin/sh

dirname="$(dirname "$0")"

distro_config_file="$dirname/../../distro-config.sh"
if [ ! -e "$distro_config_file" ]; then
        echo "$0: $distro_config_file does not exist. Aborting..." >&2
        exit 1
fi

# shellcheck source=../distro-config.sh
. "$distro_config_file"

shell_config_backup_directory="$DISTRO_BACKUP_DIRECTORY/bash"
mkdir -p "$shell_config_backup_directory"

timestamp=$(date "+%Y-%m-%d-%H%M%S")
if [ -z "$timestamp" ]; then
        echo "$0: Could not generate timestamp using date command" >&2
        exit 1
fi

if [ -f "$HOME/.bashrc" ]; then
       echo ".bashrc exists. Backing up at $shell_config_backup_directory"
       cp "$HOME/.bashrc" "$shell_config_backup_directory/.backup-bashrc-$timestamp"
fi

if [ -f "$HOME/.bash_profile" ]; then
       echo ".bash_profile exists. Backing up at $shell_config_backup_directory"
       cp "$HOME/.bash_profile" "$shell_config_backup_directory/.backup-bash-profile-$timestamp"
fi

# Copy .bashrc and .bash_profile config files to home directory
echo "Overriding .bashrc and .bash_profile at $HOME"

shell_common_config="$dirname"'/../common/common-config.sh'
if [ ! -e "$shell_common_config" ]; then
        echo "$0: $shell_common_config does not exist. Aborting..." >&2
        exit 1
fi
cat "$shell_common_config" > "$HOME/.bashrc"

bash_profile="$dirname"'/.bash_profile'
if [ ! -e "$bash_profile" ]; then
        echo "$0: $bash_profile does not exist. Aborting..." >&2
        exit 1
fi

# shellcheck source=/dev/null
cp "$bash_profile" "$HOME/.bash_profile" \
        && . "$HOME/.bash_profile"

