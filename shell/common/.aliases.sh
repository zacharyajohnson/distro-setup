#!/bin/sh

_git_all_commits() {
        git log --all --reverse | grep '^commit' | awk '{print $2}'
}

_dir_files_total_line_count() {
        cmd='find . -type f -path "*"'

        first_loop=true
        for reg_expression in "$@"
        do
                if [ "$first_loop" = true ]; then
                        cmd=$(printf "%s | grep" "$cmd")
                        first_loop=false
                fi

                if [ -z "$reg_expression" ]; then
                        reg_expression="*"
                fi

                cmd=$(printf "%s -e \\$reg_expression\$" "$cmd")
        done

        cmd=$(printf "%s | xargs wc -l | sort -n" "$cmd" | sed -e 's/,/ /g')

        eval "$cmd"
}

alias git-all-commits='_git_all_commits'

alias dir-files-total-line-count='_dir_files_total_line_count'
alias find-dirs='find . -maxdepth 1 -type d'
