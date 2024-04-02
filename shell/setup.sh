#!/bin/sh

if [ -z "$HOME" ]; then
        echo "HOME environment variable is not set"
        exit 1
fi

script_folder="$HOME/.distro-config/bin"
export_folder="$HOME/.distro-config/export"
alias_folder="$HOME/.distro-config/alias"

mkdir -p "$script_folder"
mkdir -p "$export_folder"
mkdir -p "$alias_folder"

dirname="$(dirname "$0")"
# Copy over inputrc so I stop hearing that damn bell
cp "$dirname"'/common/.inputrc' "$HOME"

cp "$dirname"/common/script/* "$script_folder"

# Copy over exports that are common across all shells
cp "$dirname"'/common/common-export.sh' "$export_folder"

cp "$dirname"'/common/common-alias.sh' "$alias_folder"

# We only want to truly install bourne shell
# configs if it isn't a symlink to another implementation
# Example: Debian links /bin/sh to dash while FreeBSD has a true
# bourne shell implementation
if [ "$SHELL" = '/bin/sh' ] && [ ! -L "$SHELL" ]; then
        echo 'Detected borne shell. Installing configs...'
        "$dirname"'/sh/setup.sh'
elif [ "$SHELL" = '/bin/bash' ];
then
        echo 'Detected bash shell. Installing configs...'
        "$dirname"'/bash/setup.sh'
fi
