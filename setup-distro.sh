#!/bin/sh

set -e

cd shell && ./setup.sh
cd ../

cd software && ./setup.sh "$1"
