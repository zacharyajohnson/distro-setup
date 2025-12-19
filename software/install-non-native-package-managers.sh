#!/bin/sh

dirname="$(dirname "$0")"
. "$dirname/function.sh"

native_package_manager="$(_get_native_package_manager)"
non_native_package_managers='flatpak brew'

# Give me a chance to install other package managers
# in case some software are only setup to be installed
# using them
for non_native_package_manager in $non_native_package_managers
do
        directory="$dirname/$non_native_package_manager"
        if ! "$dirname/install-software-and-files.sh" "$directory" "$native_package_manager"; then
                printf '%s: Setup failed for %s\n' "$0" "$non_native_package_manager" >&2
                exit 1
        fi
done
