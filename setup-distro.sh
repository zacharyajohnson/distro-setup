#!/bin/sh

set -e

#Creating a bin directory at the current logged in users home and add it to the PATH variable so we can execute any scripts that are convenent to run anywhere
echo "creating $HOME/bin" && mkdir -p "$HOME/bin"

cd shell && ./setup.sh
cd ../

cd software && ./setup.sh "$1"
