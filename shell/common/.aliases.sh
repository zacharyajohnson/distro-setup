#!/bin/sh

_git_all_commits() {
        git log --all --reverse | grep '^commit' | awk '{print $2}'
}

_dir_files_total_line_count() {
        file_search_max_depth=1
        parameter_offset=1


        if [ "$1" = "-maxdepth" ]; then
                file_search_max_depth="$2"

                parameter_offset=3
        fi

        cmd="find -maxdepth $file_search_max_depth -type f" 

        arg_total_count="$#"
        arg_count="$parameter_offset"

        first_loop=true
        for reg_expression in "${@:$parameter_offset}"
        do
                if [ "$first_loop" = true ]; then
                        cmd=$(printf "%s \\( " "$cmd")
                        first_loop=false
                fi

                if [ "$arg_count" -eq "$arg_total_count" ]; then
                        if [ -z "$reg_expression" ]; then
                                reg_expression="*"
                        fi
                        cmd=$(printf "%s -iname \"%s\"" "$cmd" "$reg_expression")
                        if [ -n "$3" ] || [ $parameter_offset -eq 1 ]; then
                                cmd=$(printf "%s \\)" "$cmd")
                        fi
                else
                        cmd=$(printf "%s -iname \"%s\" -o" "$cmd" "$reg_expression")
                        arg_count=$((arg_count+1))
                fi
        done
      
        cmd=$(printf "%s -print0 | xargs -0 wc -l" "$cmd" | sed -e 's/,/ /g')
        eval "$cmd"
}

alias git-all-commits='_git_all_commits'

alias dir-files-total-line-count='_dir_files_total_line_count'
alias find-dirs='find . -maxdepth 1 -type d'
