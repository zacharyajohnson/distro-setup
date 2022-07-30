#!/bin/sh

_git_all_commits() {
        git log --all --reverse | grep '^commit' | awk '{print $2}'
}

alias find-dirs='find . -maxdepth 1 -type d'
alias git-all-commits='_git_all_commits'
