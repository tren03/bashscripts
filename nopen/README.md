# `nopen` Script

## Overview

This script automates the creation of a **tmux session** named after the current working directory. Inside the tmux session, it opens the current directory in **Neovim** and creates a second window for the terminal. If the session with the same name already exists, the script will attach to the existing session instead of creating a new one.

## Features

- Automatically creates a **tmux session** named after the current directory.
- Opens the directory in **Neovim** in the first tmux window.
- Creates a second tmux window for running terminal commands.
- If a session with the same name already exists, the script attaches to it.

## Use

- Copy this script to your scripts directory, or wherever you please -> nopen.sh
- Run this command to make the script executable ```chmod +x nopen.sh```
- Add this to your .bashrc ``` nopen(){
    <path-to-nopen.sh>
  }```
- Run ``` source .bashrc ``` in home folder


