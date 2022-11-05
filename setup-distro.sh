#!/bin/sh

#Creating a bin directory at the current logged in users home and add it to the PATH variable so we can execute any scripts that are convenent to run anywhere
echo "creating $HOME/bin" && mkdir -p "$HOME/bin"

# We only want to truly install bourne shell
# configs if it isn't a symlink to another implementation
# Example: Debian links /bin/sh to dash while FreeBSD has a true
# bourne shell implementation
if [ "$SHELL" = '/bin/sh' ] && [ ! -L "$SHELL" ]; then
        (
        echo 'Detected borne shell. Installing configs...'
        cd 'shell/sh' \
        && chmod u+x 'setup.sh' && './setup.sh'
        )
elif [ "$SHELL" = '/bin/bash' ];
then
        (
        echo 'Detected bash shell. Installing configs...'
        cd 'shell/bash' \
        && chmod u+x 'setup.sh' && './setup.sh'
        )
fi

cd software && ./setup.sh "$1"
