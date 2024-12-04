#!/bin/sh

dirname="$(dirname "$0")"

. "$dirname/function.sh"

software_option_flag="$1"

native_package_manager="$(_get_native_package_manager)"

non_native_package_manager="$(_get_non_native_package_manager)"

package_managers="$native_package_manager $non_native_package_manager no-package-manager"

"$dirname/install-non-native-package-managers.sh"

# Get all folders in the dir and strip the ending slash in the folder.
# This is used to skip trying to install already installed packages..
# We need to get rid of the ending slash so our package query
# command works correctly.
for folder in $(echo "$dirname/*/")
do
        folder_name="$(basename "$folder")"
        for package_manager in $package_managers
        do
                if "$dirname/install-software-and-files.sh" "$folder" "$package_manager" "$software_option_flag"; then
                        break
                else
                        echo "$0: Installing with $package_manager for $folder_name failed" >&2
                fi
        done
done
