# Webpass Script

## Overview

The `webpass` script is a command-line utility for securely storing and retrieving passwords for different websites. It keeps your passwords in a hidden file in your home directory and provides encryption and secure handling of passwords.

## Features

- **Store Passwords:** Add or update passwords for different websites.
- **Retrieve Passwords:** Fetch stored passwords and generate secure representations.
  
## Flow
![image](https://github.com/user-attachments/assets/afef0479-bf58-4e63-b4f0-70d3968612cd)


    

## Prerequisites
- bash shell

## Installation

1. Copy the `webpass` function to your `.bashrc` or `.zshrc` file

2. Reload your shell configuration file:

    ```bash
    source ~/.bashrc  # or `source ~/.zshrc` if using zsh    ```

## Usage

### Storing a Password

To store a new password for a website or update an existing password:

```bash
webpass <website>
```

To get existing password:

```bash
webpass -g <website>
```
Error: site cannot be empty : Ensure you provide a website argument when storing passwords.

Error: Password cannot be empty : Make sure to input a password when prompted.

## File Location
Passwords are stored in a hidden file located at $HOME/.password_store. The file is created with secure permissions to ensure privacy.

