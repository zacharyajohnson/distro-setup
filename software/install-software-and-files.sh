#!/bin/sh

dirname="$(dirname "$0")"

directory="$1"
package_manager="$2"
software_flag="$3"
force_install="$4"

if [ "$#" -lt 2 ]; then
        printf '%s: usage: directory package_manager [software_flag force_install]. Args: %s\n' "$0" "$*" >&2
        exit 1
fi


software_option=$(echo "$software_flag" | awk -F '=' '{print $1}')
software_option_values="$(echo "$software_flag" | awk -F '=' '{print $2}' | sed 's/,/ /g')"

if [ -n "$software_option" ]; then
        if [ "$software_option" != '--software' ]; then
                printf '%s: Invalid option. Only valid option is --software\n' "$0" >&2
                exit 1
        fi
fi

directory_name="$(basename "$directory")"
should_install=false

for software_option_value in $software_option_values
do
        if [ "$software_option_value" = "$directory_name" ]; then
                should_install=true
                break
        fi
done

if [ -z "$software_option_values" ] || [ "$software_option_values" = 'all' ]; then
        should_install=true
fi


if [ "$should_install" = true ]; then
        install_package_manager_script_name="install-with-$package_manager.sh"

        if [ ! -e "$directory/$install_package_manager_script_name" ]; then
                echo "$0: Install script does not exist. package-manager=$package_manager, directory=$directory"
                exit 1
        fi

        answer=""
        if [ "$force_install" != '--force-install' ]; then
                printf '\nWould you like to install %s with %s?\n' "$directory_name" "$package_manager"
                read -r answer
        fi

        if [ "$answer" = 'y' ] || [ "$answer" = 'Y' ] || [ "$force_install" = '--force-install' ]; then
                printf 'Installing %s with %s\n' "$directory" "$package_manager"
                if "$directory/$install_package_manager_script_name"; then
                        "$dirname"'/install-config-files.sh' "$directory"
                        "$dirname"'/install-scripts.sh' "$directory"
                        "$dirname"'/install-alias-files.sh' "$directory"
                        "$dirname"'/install-export-files.sh' "$directory"
                        "$dirname"'/move-cron-files.sh' "$directory"
                else
                        printf '%s: Package installation failed for %s\n' "$0" "$directory_name" >&2
                fi
        else
                printf 'Skipping %s installation.\n\n' "$directory"
                exit 0
        fi
else
        printf '%s is not part of --software (%s). Skipping...\n' "$directory" "$software_option_values"
        exit 0
fi
