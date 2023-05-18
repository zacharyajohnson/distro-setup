#!/bin/sh 

# Gets all commit hashes and displays them in chronological order
_git_all_commits() {
        git log --all --reverse | grep '^commit' | awk '{print $2}'
}

alias git-all-commits='_git_all_commits'
