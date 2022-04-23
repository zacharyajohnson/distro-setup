#!/bin/sh

get_install_command() {
        apt-get > /dev/null 2>&1
        apt_get_error_code=$?

        brew > /dev/null 2>&1
        brew_error_code=$?

        if [ $apt_get_error_code -eq 1 ]; then
                export install_command='sudo apt-get install -y'
                printf "%s" "$install_command"
                return 0
        elif [ $brew_error_code -eq 1 ]; then
                export install_command='brew install'
                printf "%s" "$install_command"
                return 0
        else
                return 1
        fi
}

export install_command=$(get_install_command)

if [ ! $? -eq 0 ]; then
        echo 'Could not find valid package manager. Aborting software installation...'
        return 1
else
        echo "Setting package install command to: $install_command"
fi

for folder in $(ls -d */)
do
        echo "Would you like to install $folder?"
        read answer

        if [ "$answer" = 'y' ] || [ "$answer" = 'Y' ];
        then
                if [ -f $folder/setup.sh ];
                then
                (
                        cd $folder/
                        sudo chmod u+x setup.sh && sh setup.sh
                )
                fi
        else
                echo "Skipping $folder."
        fi

done
