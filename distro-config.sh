#!/bin/sh

# Config for distro-setup paths

# This file is used by install scripts and copied to ~/.distro/distro-config.sh
# for use by the shell config.

if [ -z "$HOME" ]; then
	printf '%s: HOME environment variable is not set\n' "$0" >&2
	exit 1
fi

DISTRO_BASE_DIRECTORY="$HOME/.distro"
DISTRO_SCRIPT_DIRECTORY="$DISTRO_BASE_DIRECTORY/script"
DISTRO_EXPORT_DIRECTORY="$DISTRO_BASE_DIRECTORY/export"
DISTRO_ALIAS_DIRECTORY="$DISTRO_BASE_DIRECTORY/alias"
DISTRO_BACKUP_DIRECTORY="$DISTRO_BASE_DIRECTORY/backup"
DISTRO_CRON_DIRECTORY="$DISTRO_BASE_DIRECTORY/cron"

export DISTRO_BASE_DIRECTORY
export DISTRO_SCRIPT_DIRECTORY
export DISTRO_EXPORT_DIRECTORY
export DISTRO_ALIAS_DIRECTORY
export DISTRO_BACKUP_DIRECTORY
export DISTRO_CRON_DIRECTORY
