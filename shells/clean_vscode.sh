#!/bin/bash

echo "Closing Visual Studio Code..."
# Gracefully kill VS Code process so no file handles are locked
pkill -f "Visual Studio Code" 2>/dev/null
sleep 2

echo "Analyzing and clearing VS Code caches..."
echo "--------------------------------------------------------"

# 1. Clear Extension Host Cache & JavaScript/TypeScript V8 compile data
# This is usually the largest chunk of invisible bloat.
if [ -d "$HOME/Library/Application Support/Code/CachedData" ]; then
    echo "--> Removing Extension Host Cache..."
    rm -rf "$HOME/Library/Application Support/Code/Code Cache"
    rm -rf "$HOME/Library/Application Support/Code/CachedData"
    rm -rf "$HOME/Library/Application Support/Code/CachedExtensionVSIXs"
fi

# 2. Clear Workspace Storage
# VS Code saves state history for every single project folder you've ever opened. 
# Wiping this clears out massive ancient project indexes you no longer work on.
if [ -d "$HOME/Library/Application Support/Code/User/workspaceStorage" ]; then
    echo "--> Removing Old Workspace States..."
    rm -rf "$HOME/Library/Application Support/Code/User/workspaceStorage"
fi

# 3. Clear system-level application cache files
if [ -d "$HOME/Library/Caches/com.microsoft.VSCode" ]; then
    echo "--> Removing Standalone Application Caches..."
    rm -rf "$HOME/Library/Caches/com.microsoft.VSCode"
    rm -rf "$HOME/Library/Caches/com.microsoft.VSCode.ShipIt"
fi

echo "--------------------------------------------------------"
echo "VS Code storage has been successfully trimmed down!"
echo "Reopening Visual Studio Code..."

# Reopen the application fresh
open -a "Visual Studio Code"