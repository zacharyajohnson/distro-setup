#!/bin/sh
_install_config_files() {
        folder=$1
        if [ -f "$folder/install_config.sh" ]; then
                echo "Installing config for $folder"
                (
                        cd "$folder" \
                               && chmod u+x 'install_config.sh' && './install_config.sh'

                )
        fi
}

_install_bin_scripts() {
        folder=$1

        if [ -f "$folder/install_bin_scripts.sh" ]; then
                echo "Installing bin files for $folder"
                (
                        cd "$folder" \
                                && chmod u+x 'install_bin_scripts.sh' && './install_bin_scripts.sh'
                )
        fi
}

_get_package_commands() {
        apt-get > /dev/null 2>&1
        apt_get_error_code=$?

        brew > /dev/null 2>&1
        brew_error_code=$?

	pkg help > /dev/null 2>&1
	free_bsd_error_code=$?

        if [ $apt_get_error_code -eq 1 ]; then
                export install_command='sudo apt-get install -y'
                export check_command='dpkg -s'
                return 0
        elif [ $brew_error_code -eq 1 ]; then
                export install_command='brew install'
                export check_command='brew list'
                return 0
	elif [ $free_bsd_error_code -eq 0 ]; then
		export install_command='sudo pkg install'
		export check_command='pkg info'
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


if _get_package_commands; then
        echo "Setting package install command to: $install_command"
        echo "Setting package check command to: $check_command"
else
        echo 'Could not find valid package manager. Aborting software installation...'
        return 1
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
     
        if $check_command $folder > '/dev/null' 2>&1; then
                echo "$folder already installed. Skipping..."
                _install_config_files "$folder"
                _install_bin_scripts "$folder"
        elif [ "$should_install" = true ]; then

                echo "Would you like to install $folder?"
                read -r answer

                if [ "$answer" = 'y' ] || [ "$answer" = 'Y' ]; then
                        if [ -f "$folder/setup.sh" ];
                        then
                        (
                                cd "$folder" \
                                        && chmod u+x 'setup.sh' && './setup.sh'
                        )
                        fi
                else
                        echo "Skipping $folder."
                fi
        else
                echo "$folder is not part of profile(s) ($profile_option_values). Skipping..."
        fi
done
