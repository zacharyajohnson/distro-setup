#!/bin/sh

# $1 - The first command that should be exected.
# Appears on the leftmost pane

# $2 - The second command that should be executed.
# Appears on the rightmost pane

# Create a tmux session with name vertical-session
tmux new-session -d -s vertical-session -n main-window

# Set first pane to be called after the first command
tmux select-pane -t 0 -T "$1"

# Create a vertical window to the right for the second command
tmux split-window -h
tmux select-pane -t 1 -T "$2"

# Send the commands to both windows to execute them
tmux send-keys -t 'vertical-session:main-window.0' "$1" C-m
tmux send-keys -t 'vertical-session:main-window.1' "$2" C-m

# Select our left most pane
tmux select-pane -t 0

# Attach to the vertical session now that configuration is done
tmux attach-session -t vertical-session
