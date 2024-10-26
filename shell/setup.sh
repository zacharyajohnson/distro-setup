#!/bin/sh
if [ -z "$HOME" ]; then
        echo "$0 HOME environment variable is not set" >&2
        exit 1
fi

distro_script_folder="$HOME/.distro/script"
distro_export_folder="$HOME/.distro/export"
distro_alias_folder="$HOME/.distro/alias"

mkdir -p "$distro_script_folder"
mkdir -p "$distro_export_folder"
mkdir -p "$distro_alias_folder"

dirname="$(dirname "$0")"
# Copy over inputrc so I stop hearing that damn bell


inputrc="$dirname"'/common/.inputrc'
if [ ! -e "$inputrc" ]; then
        echo "$0: $inputrc does not exist. Aborting..." >&2
        exit 1
fi
cp "$inputrc" "$HOME"


common_script="$dirname"'/common/script'
if [ ! -d "$common_script" ]; then
        echo "$0: $common_script does not exist. Aborting..." >&2
        exit 1
fi
cp "$common_script"/* "$distro_script_folder"


common_export="$dirname"'/common/common-export.sh'
if [ ! -e "$common_export" ]; then
        echo "$0: $common_export does not exist. Aborting..." >&2
        exit 1
fi
# Copy over exports that are common across all shells
cp "$common_export" "$distro_export_folder"


common_alias="$dirname"'/common/common-alias.sh'
if [ ! -e "$common_alias" ]; then
        echo "$0: $common_alias does not exist. Aborting..." >&2
        exit 1
fi
cp "$common_alias" "$distro_alias_folder"

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
else
        echo "$0: Could not detect shell installed. Aborting..." >&2
        exit 1
fi
