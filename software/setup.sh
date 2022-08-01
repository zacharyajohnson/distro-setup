#!/bin/sh

_get_install_command() {
        apt-get > /dev/null 2>&1
        apt_get_error_code=$?

        brew > /dev/null 2>&1
        brew_error_code=$?

        if [ $apt_get_error_code -eq 1 ]; then
                export install_command='sudo apt-get install -y'
                return 0
        elif [ $brew_error_code -eq 1 ]; then
                export install_command='brew install'
                return 0
        else
                return 1
        fi
}

if _get_install_command; then
        echo "Setting package install command to: $install_command"
else
        echo 'Could not find valid package manager. Aborting software installation...'
        return 1
fi

for folder in */
do
        echo "Would you like to install $folder?"
        read -r answer

        if [ "$answer" = 'y' ] || [ "$answer" = 'Y' ];
        then
                if [ -f "$folder/setup.sh" ];
                then
                (
                        cd "$folder" \
                        && sudo chmod u+x 'setup.sh' && './setup.sh'
                )
                fi
        else
                echo "Skipping $folder."
        fi

done
