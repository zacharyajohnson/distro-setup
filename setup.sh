#!/bin/sh

set -e

(
        cd shell && ./setup.sh
)

(
        cd software && ./setup.sh "$1"
)
