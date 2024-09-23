#!/bin/bash

# Thoughts : When i run nopen, i want to create a tmux session with the name of the current dir i am in, and in that open that dir in nvim and open a second window for my project termainal

# Get current dir name
current_dir=$(basename "$PWD")
echo "Current directory: $current_dir"

# Create a tmux session with current_dir name and add a second terminal window to the session only if the session already doesnt exist

# Getting all sessions
all_sessions=$(tmux ls | cut -d ":" -f 1)

# Checking if needed sesh is already in list
if echo "$all_sessions" | grep -q "^$current_dir$"; then
	echo "Session '$current_dir' exists, joining that..."
	tmux attach -t "$current_dir"
else
	echo "Session '$current_dir' does not exist, Creating one..."
    # Create a session in detach mode, add the project terminal and then attach it
	tmux new-session -d -s"$current_dir" -- nvim .
	tmux neww -d -t"$current_dir"
    
	tmux attach -t "$current_dir"

fi
