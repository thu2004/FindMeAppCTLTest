#!/bin/bash

# Switch to Xcode Beta
# This script switches the active Xcode version to Xcode Beta

echo "🔄 Switching to Xcode Beta..."
echo ""

# Check if Xcode Beta exists
if [ ! -d "/Applications/Xcode-beta.app" ]; then
    echo "❌ Error: Xcode Beta not found at /Applications/Xcode-beta.app"
    exit 1
fi

# Switch to Xcode Beta (requires sudo)
sudo xcode-select -s /Applications/Xcode-beta.app/Contents/Developer

if [ $? -eq 0 ]; then
    echo "✅ Successfully switched to Xcode Beta"
    echo ""
    echo "Current Xcode:"
    xcode-select -p
    echo ""
    echo "Xcode version:"
    xcodebuild -version
else
    echo "❌ Failed to switch to Xcode Beta"
    exit 1
fi
