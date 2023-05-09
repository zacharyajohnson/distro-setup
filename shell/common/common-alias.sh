#!/bin/sh

_git_all_commits() {
        git log --all --reverse | grep '^commit' | awk '{print $2}'
}

_dir_files_total_line_count() {
        if [ $# -lt 2 ]; then
                    echo "Usage: dir-files-total-line-count <directory> <file_extension1> <file_extension2> ..."
                    return 1
        fi

        directory="$1"
        shift


        # Iterate through each file extension and call the function
        for file_extension in "$@"
        do
                printf "Total for .$file_extension\n"
                find "$directory" -type f -name "*.$file_extension" -exec wc -l {} + | sort -n
        done

}


alias git-all-commits='_git_all_commits'

alias dir-files-total-line-count='_dir_files_total_line_count'
alias find-dirs='find . -maxdepth 1 -type d'
