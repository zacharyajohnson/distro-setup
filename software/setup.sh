#!/bin/sh

_get_native_package_manager() {
        if which dpkg > '/dev/null' 2>&1; then
                printf 'dpkg'
                return 0
        elif which pkg > '/dev/null' 2>&1; then
                printf 'pkg'
                return 0
        elif which pacman > '/dev/null' 2>&1; then
                printf 'pacman'
                return 0
        elif which apk > '/dev/null' 2>&1; then
                printf 'apk'
                return 0
        else
                return 1
        fi
}

_get_non_native_package_manager() {
        if which flatpak > '/dev/null' 2>&1; then
                printf 'flatpak'
                return 0
        elif which brew > '/dev/null' 2>&1; then
                printf 'brew'
                return 0
        else
                return 1
        fi

}

_setup_software() {
        dirname="$(dirname "$0")"

        folder="$1"
        software_option_values="$2"
        native_package_manager="$3"
        non_native_package_manager="$4"

        if [ "$#" -lt 4 ]; then
                echo "$0: _setup_software usage: folder software_option_values native_package_manager non_native_package_manager. Args: $*" >&2
                return 1
        fi

        folder_name="$(basename "$folder")"
        should_install=false

        for software_option_value in $software_option_values
        do
                if [ "$software_option_value" = "$folder_name" ]; then
                        should_install=true
                        break;
                fi
        done

        if [ -z "$software_option_values" ]; then
                should_install=true
        fi
     
        install_native_script_name="install-with-$native_package_manager.sh"
        install_non_native_script_name="install-with-$non_native_package_manager.sh"

        if [ "$should_install" = true ]; then
                printf '\nWould you like to install %s?\n' "$folder_name"
                read -r answer

                if [ "$answer" = 'y' ] || [ "$answer" = 'Y' ]; then
                        if [ -e "$folder/$install_native_script_name" ]; then
                                printf 'Installing %s with %s\n' "$folder" "$native_package_manager"
                                "$folder/$install_native_script_name"

                                "$dirname"'/install-config-files.sh' "$folder"
                                "$dirname"'/install-scripts.sh' "$folder"
                                "$dirname"'/install-alias-files.sh' "$folder"
                                "$dirname"'/install-export-files.sh' "$folder"
                                "$dirname"'/move-cron-files.sh' "$folder"
                        elif [ -e "$folder/$install_non_native_script_name" ]; then
                                printf 'Installing %s with %s\n' "$folder" "$non_native_package_manager"
                                "$folder/$install_non_native_script_name"

                                "$dirname"'/install-config-files.sh' "$folder"
                                "$dirname"'/install-scripts.sh' "$folder"
                                "$dirname"'/install-alias-files.sh' "$folder"
                                "$dirname"'/install-export-files.sh' "$folder"
                                "$dirname"'/move-cron-files.sh' "$folder"
                        elif [ -e "$folder/install-with-no-package-manager.sh" ]; then
                                printf 'Manually installing %s with no package manager\n' "$folder"
                                "$folder/install-with-no-package-manager.sh"

                                "$dirname"'/install-config-files.sh' "$folder"
                                "$dirname"'/install-scripts.sh' "$folder"
                                "$dirname"'/install-alias-files.sh' "$folder"
                                "$dirname"'/install-export-files.sh' "$folder"
                                "$dirname"'/move-cron-files.sh' "$folder"
                        else
                                printf 'Install script does not exist for %s. Skipping...\n\n' "$folder"
                        fi
                else
                        printf 'Skipping %s installation.\n\n' "$folder"
                fi
        else
                printf '%s is not part of --software(s) (%s). Skipping...\n' "$folder" "$software_option_values"
        fi

        return 0
}

software_option=$(echo "$1" | awk -F '=' '{print $1}')
software_option_values="$(echo "$1" | awk -F '=' '{print $2}' | sed 's/,/ /g')"

if [ -n "$software_option" ]; then
        if [ "$software_option" != '--software' ]; then
                echo "$0: Invalid option. Only valid option is --software" >&2
                exit 1
        elif [ -z "$software_option_values" ]; then
                echo "$0: No arguments for --software" >&2
                exit 1
        fi
fi

native_package_manager="$(_get_native_package_manager)"

dirname="$(dirname "$0")"
non_native_package_managers='flatpak brew'

# Give me a chance to install other package managers
# in case some software are only setup to be installed
# using them
for non_native_package_manager_folder in $non_native_package_managers
do
        if ! _setup_software "$dirname/$non_native_package_manager_folder" "$software_option_values" "$native_package_manager" 'none'; then
                echo "$0: Setup failed for $non_native_package_manager_folder" >&2
                exit 1
        fi
done


non_native_package_manager="$(_get_non_native_package_manager)"
# Get all folders in the dir and strip the ending slash in the folder.
# This is used to skip trying to install already installed packages..
# We need to get rid of the ending slash so our package query
# command works correctly.
for folder in $(echo "$dirname/*/")
do
       if ! _setup_software "$folder" "$software_option_values" "$native_package_manager" "$non_native_package_manager"; then
                echo "$0: Setup failed for $non_native_package_manager_folder" >&2
                exit 1
       fi
done

