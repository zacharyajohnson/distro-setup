#!/bin/sh

base_project_dir=$PWD

if [ apt ];
then
        export install_command='apt-get install -y'
elif [ brew ];
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

#Creating a bin directory at the current logged in users home and add it to the PATH variable so we can execute any scripts that are convenent to run anywhere
echo "creating $HOME/bin" && sudo mkdir -p $HOME/bin


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
