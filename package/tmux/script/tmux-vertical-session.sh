#!/bin/sh

# This script is used to create a number of vertical
# panes in a tmux session. 

# The script will take any number of commands as 
# its arguments, create a vertical pane for each command, 
# and execute that command.

# If no commands are passed in, tmux will create
# two vertical panes that start a shell. 

# If one command is passed in tmux will execute the command 
# in one pane and the other will be a pane that starts a shell.

window_name='main-window'
session_name='vert-sess'
num_commands="$#"

# Create a tmux session with name vert-session.
tmux new-session -d -s "$session_name" -n "$window_name"

if [ "$num_commands" -eq 0 ]; then
        tmux select-pane -t 0 -T ''

        tmux split-window -h
        tmux select-pane -t 1 -T ''
elif [ "$num_commands" -eq 1 ]; then
        tmux select-pane -t 0 -T "$1"

        tmux split-window -h
        tmux select-pane -t 1 -T ''

        tmux send-keys -t "$session_name:$window_name.0" "$1" C-m
else
        i=1
        while [ "$i" -le "$num_commands" ]; do
                command_variable="\$$i"
                pane_number=$((i - 1))
                command_value=$(eval echo "$command_variable")

                tmux select-pane -t "$pane_number" -T "$command_value"
                tmux send-keys -t "$session_name:$window_name.$pane_number" "$command_value" C-m

                # If i = num_commands, we are done and dont
                # want to create an extra window.
                if [ ! "$i" -eq "$num_commands" ]; then
                        tmux split-window -h
                fi

                i=$((i + 1))
        done
fi

# Select our left most pane.
tmux select-pane -t 0

# Attach to the vertical session now that configuration is done.
tmux attach-session -t "$session_name"
