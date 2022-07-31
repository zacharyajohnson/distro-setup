#!/bin/sh

#Creating a bin directory at the current logged in users home and add it to the PATH variable so we can execute any scripts that are convenent to run anywhere
echo "creating $HOME/bin" && mkdir -p "$HOME/bin"

if [ "$SHELL" = '/bin/bash' ];
then
        (
        echo 'Detected bash shell. Installing configs...'
        cd 'shell/bash' \
        && sudo chmod u+x 'setup.sh' && './setup.sh'
        )
fi

cd software && ./setup.sh
