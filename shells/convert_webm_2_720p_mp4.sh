#!/bin/bash

# Check if a filename was provided
if [ -z "$1" ]; then
    echo "Usage: ./convert_webm.sh input_file.webm"
    exit 1
fi

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install it first."
    exit 1
fi

INPUT="$1"
# Extract filename without extension and add .mp4
OUTPUT="${INPUT%.*}.mp4"

echo "Converting '$INPUT' to '$OUTPUT' (720p optimized)..."

ffmpeg -i "$INPUT" \
    -vf "scale=-2:720" \
    -c:v libx264 \
    -crf 23 \
    -preset slow \
    -c:a aac \
    -b:a 128k \
    -movflags +faststart \
    "$OUTPUT"

if [ $? -eq 0 ]; then
    echo "Success! File saved as: $OUTPUT"
else
    echo "Error: Conversion failed."
fi