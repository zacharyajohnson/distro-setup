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
        folder="$dirname/$non_native_package_manager"
        if ! "$dirname/install-software-and-files.sh" "$folder" "$native_package_manager" "$software_option_values"; then
                echo "$0: Setup failed for $non_native_package_manager" >&2
                exit 1
        fi
done
