#!/bin/sh

dirname="$(dirname "$0")"

folder="$1"
package_manager="$2"
software_flag="$3"

if [ "$#" -lt 3 ]; then
        echo "$0: usage: folder package_manager software_flag. Args: $*" >&2
        exit 1
fi


software_option=$(echo "$software_flag" | awk -F '=' '{print $1}')
software_option_values="$(echo "$software_flag" | awk -F '=' '{print $2}' | sed 's/,/ /g')"

if [ -n "$software_option" ]; then
        if [ "$software_option" != '--software' ]; then
                echo "$0: Invalid option. Only valid option is --software" >&2
                exit 1
        elif [ -z "$software_option_values" ]; then
                echo "$0: No arguments for --software" >&2
                exit 1
        fi
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


if [ "$should_install" = true ]; then
        install_package_manager_script_name="install-with-$package_manager.sh"

        if [ ! -e "$folder/$install_package_manager_script_name" ]; then
                echo "$0: Install script does not exist. package-manager=$package_manager, folder=$folder"
                exit 1
        fi

        printf '\nWould you like to install %s with %s?\n' "$folder_name" "$package_manager"
        read -r answer

        if [ "$answer" = 'y' ] || [ "$answer" = 'Y' ]; then
                printf 'Installing %s with %s\n' "$folder" "$package_manager"
                "$folder/$install_package_manager_script_name"

                "$dirname"'/install-config-files.sh' "$folder"
                "$dirname"'/install-scripts.sh' "$folder"
                "$dirname"'/install-alias-files.sh' "$folder"
                "$dirname"'/install-export-files.sh' "$folder"
                "$dirname"'/move-cron-files.sh' "$folder"
        else
                printf 'Skipping %s installation.\n\n' "$folder"
                exit 0
        fi
else
        printf '%s is not part of --software (%s). Skipping...\n' "$folder" "$software_option_values"
        exit 0
fi
