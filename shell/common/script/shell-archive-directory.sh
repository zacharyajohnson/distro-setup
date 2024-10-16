#!/bin/sh

if [ "$#" -lt 3 ]; then
       echo "$0 usage: directory archive_name archive_directory" >&2
       exit 1
fi

directory="$1"
archive_name="$2"
archive_directory="$3"

if [ ! -d "$directory" ]; then
        echo "$directory is not a directory. Exiting..." >&2
        echo "$0 usage: directory archive_name archive_directory" >&2
        exit 1
fi

timestamp=$(date "+%Y-%m-%d-%H%M%S")
if [ -z "$timestamp" ]; then
        echo "$0: Could not generate timestamp using date command" >&2
        exit 1
fi

tar_archive_name="$archive_name-$timestamp.tar.gz"

# gz compression
tar -c -f "$tar_archive_name" -z -v "$directory"

mkdir -p "$archive_directory" \
        && mv -i "$tar_archive_name" "$archive_directory"
