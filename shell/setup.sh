#!/bin/sh

set -e

export_folder="$HOME/.distro-config/export"
alias_folder="$HOME/.distro-config/alias"

mkdir -p "$export_folder"
mkdir -p "$alias_folder"

# Copy over inputrc so I stop hearing that damn bell
cp 'common/.inputrc' "$HOME"

# Copy over exports that are common across all shells
cp 'common/common-export.sh' "$export_folder"

cp 'common/common-alias.sh' "$alias_folder"

# We only want to truly install bourne shell
# configs if it isn't a symlink to another implementation
# Example: Debian links /bin/sh to dash while FreeBSD has a true
# bourne shell implementation
if [ "$SHELL" = '/bin/sh' ] && [ ! -L "$SHELL" ]; then
        (
        echo 'Detected borne shell. Installing configs...'
        cd 'sh' \
        && chmod u+x 'setup.sh' && './setup.sh'
        )
elif [ "$SHELL" = '/bin/bash' ];
then
        (
        echo 'Detected bash shell. Installing configs...'
        cd 'bash' \
        && chmod u+x 'setup.sh' && './setup.sh'
        )
fi
