#!/bin/sh

dirname="$(dirname "$0")"

. "$dirname/function.sh"

software_option_flag="$1"
force_install="$2"
native_only="$3"

native_package_manager="$(_get_native_package_manager)"

non_native_package_manager="$(_get_non_native_package_manager)"

package_managers="$native_package_manager $non_native_package_manager no-package-manager"

if [ "$native_only" != '--native-packages-only' ]; then
        "$dirname/install-non-native-package-managers.sh"
fi

# Get all directories in the dir and strip the ending slash in the directory.
# This is used to skip trying to install already installed packages..
# We need to get rid of the ending slash so our package query
# command works correctly.
for directory in "$dirname"/*/
do
        directory_name="$(basename "$directory")"
        for package_manager in $package_managers
        do
                if "$dirname/install-software-and-files.sh" "$directory" "$package_manager" "$software_option_flag" "$force_install"; then
                        break
                else
                        printf '%s: Installing with %s for %s failed\n' "$0" "$package_manager" "$directory_name" >&2
                fi
        done
done
