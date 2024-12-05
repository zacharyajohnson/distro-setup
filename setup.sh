#!/bin/sh

if ! "$(dirname "$0")"'/shell/setup.sh'; then
        exit 1
fi

if ! "$(dirname "$0")"'/software/setup.sh' "$1" "$2" "$3"; then
        exit 1
fi

