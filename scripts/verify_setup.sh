#!/bin/bash

# Verify Setup Script for FindMeAppCTLTest
# This script checks that all files are properly set up and the project builds

set -e

echo "🔍 Verifying FindMeAppCTLTest Setup..."
echo ""

# Check if we're in the right directory
if [ ! -f "FindMeAppCTLTest.xcodeproj/project.pbxproj" ]; then
    echo "❌ Error: Must run from project root directory"
    exit 1
fi

echo "✅ Project file found"
echo ""

# Check for required files
echo "📁 Checking UI Test files..."

required_files=(
    "FindMeAppCTLTestUITests/TestContext.swift"
    "FindMeAppCTLTestUITests/PageObjects/BasePage.swift"
    "FindMeAppCTLTestUITests/PageObjects/FindMyMainPage.swift"
    "FindMeAppCTLTestUITests/FindMeAppCTLTestUITests.swift"
    "FindMeAppCTLTestUITests/FindMeAppCTLTestUITestsLaunchTests.swift"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ Missing: $file"
        exit 1
    fi
done

echo ""
echo "📋 Listing available schemes..."
xcodebuild -list -project FindMeAppCTLTest.xcodeproj 2>/dev/null | grep -A 10 "Schemes:"

echo ""
echo "🔨 Attempting to build project..."
xcodebuild build -project FindMeAppCTLTest.xcodeproj -scheme FindMeAppCTLTest -destination 'generic/platform=iOS' 2>&1 | grep -E "(BUILD SUCCEEDED|BUILD FAILED|error:|warning:)" || true

echo ""
echo "✅ Setup verification complete!"
echo ""
echo "To run UI tests:"
echo "  xcodebuild test -project FindMeAppCTLTest.xcodeproj -scheme FindMeAppCTLTest -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:FindMeAppCTLTestUITests"
