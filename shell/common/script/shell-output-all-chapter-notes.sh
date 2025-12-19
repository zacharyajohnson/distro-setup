#!/bin/sh

root_dir="$1"
note_file='note.txt'

if [ -z "$root_dir" ]; then
        printf '%s usage: root_dir\n' "$0" >&2
        exit 1
fi

chapter_dirs=$(find "$root_dir" -mindepth 1 -maxdepth 1 -type d | sort)

for chapter_dir in $chapter_dirs
do
        note_file_path="$chapter_dir/$note_file"
        if [ -e "$note_file_path" ]; then
                cat "$note_file_path"
        else
                printf 'Could not find %s\n' "$note_file_path" >&2
        fi
done
