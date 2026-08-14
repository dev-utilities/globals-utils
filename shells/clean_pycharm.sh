#!/bin/bash
echo "Scanning for PyCharm directories..."

# 1. Dynamically find the absolute newest PyCharm folder version
# This lists the folders, filters for PyCharm, sorts them, and grabs the last one (latest).
VERSION_TO_KEEP=$(ls -1 "$HOME/Library/Caches/JetBrains" 2>/dev/null | grep -E '^PyCharm[0-9]{4}\.[0-9]' | sort -V | tail -n 1)

# Safety check: If it can't find any PyCharm folder, stop immediately so nothing is accidentally wiped out.
if [ -z "$VERSION_TO_KEEP" ]; then
    echo "Error: No active PyCharm installation folders were found."
    exit 1
fi

echo "--> Detected latest version to KEEP: $VERSION_TO_KEEP"
echo "--------------------------------------------------------"

# Array of JetBrains system directories on macOS
DIRECTORIES=(
    "$HOME/Library/Caches/JetBrains"
    "$HOME/Library/Application Support/JetBrains"
    "$HOME/Library/Logs/JetBrains"
)

# Loop through each parent directory
for DIR in "${DIRECTORIES[@]}"; do
    if [ -d "$DIR" ]; then
        echo "Checking directory: $DIR"
        
        # Find all folders starting with 'PyCharm' in that directory
        for pycharm_dir in "$DIR"/PyCharm*; do
            # Ensure it's a valid directory and check if it matches the latest version
            if [ -d "$pycharm_dir" ] && [[ ! "$pycharm_dir" == *"$VERSION_TO_KEEP"* ]]; then
                echo "    [DELETING] Old version: $(basename "$pycharm_dir")"
                rm -rf "$pycharm_dir"
            fi
        done
    fi
done

echo "--------------------------------------------------------"
echo "Cleanup complete! Only $VERSION_TO_KEEP has been preserved."