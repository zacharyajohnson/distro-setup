#!/bin/sh

if [ $# -lt 2 ]; then
            echo "$0 usage: directory file_extension1 file_extension2 ..." >&2
            exit 1
fi

directory="$1"
shift

# Iterate through each file extension and call the function
for file_extension in "$@"
do
        printf "Total for .%s\n" "$file_extension"
        find "$directory" -type f -name "*.$file_extension" -exec wc -l {} + | sort -n
done

