#!/bin/sh

if [ "$#" -lt 3 ]; then
       printf '%s usage: directory archive_name archive_directory\n' "$0" >&2
       exit 1
fi

directory="$1"
archive_name="$2"
archive_directory="$3"

if [ ! -d "$directory" ]; then
        printf '%s is not a directory. Exiting...\n' "$directory" >&2
        printf '%s usage: directory archive_name archive_directory\n' "$0" >&2
        exit 1
fi

timestamp=$(date "+%Y-%m-%d-%H%M%S")
if [ -z "$timestamp" ]; then
        printf '%s: Could not generate timestamp using date command\n' "$0" >&2
        exit 1
fi

tar_archive_name="$archive_name-$timestamp.tar.gz"

# gz compression
tar -c -f "$tar_archive_name" -z -v "$directory"

mkdir -p "$archive_directory" \
        && mv -i "$tar_archive_name" "$archive_directory"
