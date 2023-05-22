#!/bin/sh

_install_config_files() {
        folder=$1
        if [ -f "$folder/install-config.sh" ]; then
                echo "Installing configs for $folder"
                (
                        cd "$folder" \
                                && './install-config.sh'

                )
        fi
}

_install_bin_scripts() {
        folder=$1

        if [ -f "$folder/install-bin-scripts.sh" ]; then
                echo "Installing bin files for $folder"
                (
                        cd "$folder" \
                                && './install-bin-scripts.sh'
                )
        fi
}

_install_aliases() {
        folder=$1
        if [ -f "$folder/install-alias.sh" ]; then
                echo "Installing aliases for $folder"
                (
                        cd "$folder" \
                                && './install-alias.sh'

                )
        fi
}

_get_package_manager() {
        # Need the redirects to /dev/null
        # or the output of which which will be
        # part of the function value in standard out
        if which dpkg > '/dev/null'; then
                printf 'dpkg'
                return 0
        elif which brew > '/dev/null'; then
                printf 'brew'
                return 0
        elif which pkg > '/dev/null'; then
                printf 'pkg'
                return 0
        elif which packman > '/dev/null'; then
                printf 'pacman'
                return 0
        else
                return 1
        fi
}

profile_option=$(echo "$1" | awk -F '=' '{print $1}')
profile_option_values="$(echo "$1" | awk -F '=' '{print $2}' | sed 's/,/ /g')"

if [ -n "$profile_option" ]; then
        if [ "$profile_option" != '--profiles' ]; then
                echo "Invalid option. Only valid option is --profiles"
                exit 1
        elif [ -z "$profile_option_values" ]; then
                echo "No arguments for --profiles"
                exit 1
        fi
fi


if [ -z "$profile_option_values" ]; then
        profile_option_values='common'
fi


package_manager="$(_get_package_manager)"

if [ -n "$package_manager" ]; then
        printf 'Detected package manager %s\n\n' "$package_manager"
else
        printf 'Could not detect package manager. Will install software that can be installed with no package manager...\n\n'
fi

# Get all folders in the dir and strip the ending slash in the folder.
# This is used to skip trying to install already installed packages..
# We need to get rid of the ending slash so our package query
# command works correctly.
for folder in $(echo */ | sed 's/\// /g')
do
        folder_profiles=$(cat "$folder/.profiles" 2>'/dev/null')

        # If the folders profile for a piece of software doesn't exist, default to common
        # for it
        if [ -z "$folder_profiles" ]; then
                folder_profiles='common'
        fi

        should_install=false

        for profile_option_value in $profile_option_values
        do
                if echo "$folder_profiles" | grep -xq "$profile_option_value"; then
                        should_install=true
                        break;
                fi
        done
     
        install_script_name="install-with-$package_manager.sh"

        if [ "$should_install" = true ]; then
                printf '\nWould you like to install %s?\n' "$folder"
                read -r answer

                if [ "$answer" = 'y' ] || [ "$answer" = 'Y' ]; then
                        if [ -e "$folder/$install_script_name" ]; then
                                printf 'Installing %s with %s\n' "$folder" "$package_manager"
                                (
                                        cd "$folder" \
                                                && "./$install_script_name"
                                )

                                _install_config_files "$folder"
                                _install_bin_scripts "$folder"
                                _install_aliases "$folder"
                        elif [ -e "$folder/install-with-no-package-manager.sh" ]; then
                                printf 'Manually installing %s with no package manager\n' "$folder"
                                (
                                        cd "$folder" \
                                                && './install-with-no-package-manager.sh'
                                )

                                _install_config_files "$folder"
                                _install_bin_scripts "$folder"
                                _install_aliases "$folder"
                        else
                                printf 'Install script does not exist for %s. Skipping...\n\n' "$folder"
                        fi
                else
                        printf 'Skipping %s installation.\n\n' "$folder"
                fi
        else
                printf '%s is not part of profile(s) (%s). Skipping...\n' "$folder" "$profile_option_values"
        fi
done
