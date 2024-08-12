# ocrauto script

## Overview

The `ocrauto` script automates the process of taking a screenshot, performing Optical Character Recognition (OCR) on it, and opening the extracted text in a text editor. Once you close the editor, the script automatically deletes the text file.

## Features

- **Capture Screenshot:** Takes a screenshot of a selected area.
- **Perform OCR:** Uses Python to extract text from the screenshot.
- **Open in Editor:** Opens the extracted text in a text editor.
- **Cleanup:** Automatically deletes the text file after closing the editor.

## Prerequisites

- `gnome-screenshot`: For capturing screenshots.
- Python 3: Ensure Python 3 is installed.
- Python Modules: `opencv-python`, `easyocr`.

## Installation

1. **Install Required Python Modules:**

    ```bash
    pip install opencv-python easyocr
    ```

2. **Add Script to Your Shell Configuration:**

    Copy the `ocrauto` function into your `.bashrc`, `.zshrc`, or another shell configuration file:

3. **Reload Your Shell Configuration:**

    ```bash
    source ~/.bashrc  # or `source ~/.zshrc` if using zsh
    ```

## Usage

Run the script with the following command:

```bash
ocrauto
