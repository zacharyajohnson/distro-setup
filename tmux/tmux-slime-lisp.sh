#!/bin/bash

# Create a tmux session with the lisp name
tmux new-session -d -s lisp-session -n main-window 

# Set first pane to be called main shell after creation
tmux select-pane -t 0 -T main-shell

# Create a horizontal window to the right for the 
# Lisp repo
tmux split-window -h 
tmux select-pane -t 1 -T lisp-repo

# Send command to lisp-repo pain to start steel bank common lisp(sbcl)
tmux send-keys -t lisp-session:main-window.1 sbcl C-m

# Select our main-shell pain where we will edit lisp files 
tmux select-pane -t 0

# Attach to the lisp session now that configuration is done
tmux attach-session -t lisp-session
