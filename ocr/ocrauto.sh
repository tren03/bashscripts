ocrauto() {
    # Capture the screenshot and store it in a temporary file
    TEMP_FILE=$(mktemp /tmp/screenshot-XXXXXX.png)
    OUTPUT_FILE="converted.txt"
    gnome-screenshot -a -f "$TEMP_FILE"
    
    # Perform OCR using Python directly on the captured image
    python3 - <<EOF
import cv2
import easyocr
import os

# Load the screenshot image
img = cv2.imread('$TEMP_FILE')

# Perform OCR
reader = easyocr.Reader(['en'])
result = reader.readtext(img)

# Extract the text
extracted_text = ' '.join([text[1] for text in result])

# Write the text to a file
with open("$OUTPUT_FILE", "w") as f:
    f.write(extracted_text)
EOF

    # Open the file in a text editor and monitor it
    gedit "$OUTPUT_FILE" &
    gedit_pid=$!
    
    # Wait until the editor is closed
    wait $gedit_pid
    
    # Delete the file after closing the editor
    rm "$OUTPUT_FILE"
    
    # Clean up the temporary file
    rm "$TEMP_FILE"
}
