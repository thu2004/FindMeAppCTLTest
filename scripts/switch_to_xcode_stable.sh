#!/bin/bash

# Switch to Xcode Stable
# This script switches the active Xcode version back to stable Xcode

echo "🔄 Switching to Xcode Stable..."
echo ""

# Check if Xcode exists
if [ ! -d "/Applications/Xcode.app" ]; then
    echo "❌ Error: Xcode not found at /Applications/Xcode.app"
    exit 1
fi

# Switch to Xcode Stable (requires sudo)
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

if [ $? -eq 0 ]; then
    echo "✅ Successfully switched to Xcode Stable"
    echo ""
    echo "Current Xcode:"
    xcode-select -p
    echo ""
    echo "Xcode version:"
    xcodebuild -version
else
    echo "❌ Failed to switch to Xcode Stable"
    exit 1
fi
