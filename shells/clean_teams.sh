#!/bin/bash

echo "Closing Microsoft Teams..."
# Forcefully quit Teams so files aren't locked
pkill -f "Microsoft Teams" 2>/dev/null
sleep 2

echo "Clearing Microsoft Teams cache and unnecessary files..."

# Clean New Teams Caches
if [ -d "$HOME/Library/Group Containers/UBF8T346G9.com.microsoft.teams" ]; then
    rm -rf "$HOME/Library/Group Containers/UBF8T346G9.com.microsoft.teams"
fi

if [ -d "$HOME/Library/Containers/com.microsoft.teams2" ]; then
    rm -rf "$HOME/Library/Containers/com.microsoft.teams2"
fi

# Clean Classic Teams Cache (just in case any old files remain)
if [ -d "$HOME/Library/Application Support/Microsoft/Teams" ]; then
    rm -rf "$HOME/Library/Application Support/Microsoft/Teams"
fi

echo "Cache cleared successfully!"
echo "Reopening Microsoft Teams..."

# Reopen the app
open -a "Microsoft Teams"