#!/bin/sh

_shell_file_line_count_by_extension () {
        if [ $# -lt 2 ]; then
                    echo "Usage: shell-file-line-count-by-extension <directory> <file_extension1> <file_extension2> ..."
                    return 1
        fi

        directory="$1"
        shift


        # Iterate through each file extension and call the function
        for file_extension in "$@"
        do
                printf "Total for .%s\n" "$file_extension"
                find "$directory" -type f -name "*.$file_extension" -exec wc -l {} + | sort -n
        done

}



alias shell-file-line-count-by-extension='_shell_file_line_count_by_extension'
alias shell-find-dirs='find . -maxdepth 1 -type d'
