#!/bin/sh

set -e

"$(dirname "$0")"'/shell/setup.sh'

"$(dirname "$0")"'/software/setup.sh' "$1"
