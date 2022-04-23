#!/bin/sh

#Creating a bin directory at the current logged in users home and add it to the PATH variable so we can execute any scripts that are convenent to run anywhere
echo "creating $HOME/bin" && mkdir -p $HOME/bin

base_project_dir=$PWD

apt-get > /dev/null 2>&1
apt_get_error_code=$?

brew > /dev/null 2>&1
brew_error_code=$?

if [ $apt_get_error_code -eq 1 ];
then
        export install_command='sudo apt-get install -y'
elif [ $brew_error_code -eq 1 ];
then
        export install_command='brew install'
else
        echo 'Could not find valid package manager. Aborting...'
        exit 1
fi

if [ $(echo $SHELL) = '/bin/bash' ];
then
        echo 'Detected bash shell. Installing configs...'
        cd shell/bash/
        sudo chmod u+x ./setup.sh && sh -c ./setup.sh
        cd $base_project_dir
fi

echo "Setting package install command to: $install_command"

for folder in $(ls software/)
do
        echo "Would you like to install $folder?"
        read answer

        if [ "$answer" = 'y' ] || [ "$answer" = 'Y' ];
        then
                if [ -f software/$folder/setup.sh ];
                then
                        cd software/$folder/
                        sudo chmod u+x ./setup.sh && sh -c ./setup.sh
                        cd $base_project_dir
                fi
        else
                echo "Skipping $folder."
        fi

done
