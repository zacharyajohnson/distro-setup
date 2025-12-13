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

# Get all folders in the dir and strip the ending slash in the folder.
# This is used to skip trying to install already installed packages..
# We need to get rid of the ending slash so our package query
# command works correctly.
for folder in "$dirname"/*/
do
        folder_name="$(basename "$folder")"
        for package_manager in $package_managers
        do
                if "$dirname/install-software-and-files.sh" "$folder" "$package_manager" "$software_option_flag" "$force_install"; then
                        break
                else
                        echo "$0: Installing with $package_manager for $folder_name failed" >&2
                fi
        done
done
