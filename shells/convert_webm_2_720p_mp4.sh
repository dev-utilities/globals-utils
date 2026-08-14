#!/bin/bash

# Function to stop the script without closing the terminal
safe_exit() {
    # Check if the script is being sourced or executed
    if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
        return 1 # If sourced, just return
    else
        exit 1   # If executed, exit the subshell
    fi
}

# Check if a filename was provided
if [ -z "$1" ]; then
    echo "Usage: $0 input_file.webm"
    safe_exit
fi

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed."
    safe_exit
fi

INPUT="$1"
OUTPUT="${INPUT%.*}.mp4"

echo "Converting '$INPUT' to '$OUTPUT'..."

ffmpeg -i "$INPUT" -vf "scale=-2:720" -c:v libx264 -crf 23 -preset slow -c:a aac -b:a 128k -movflags +faststart "$OUTPUT"

if [ $? -eq 0 ]; then
    echo "Success! File saved as: $OUTPUT"
else
    echo "Error: Conversion failed."
    safe_exit
fi