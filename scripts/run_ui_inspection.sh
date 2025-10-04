#!/bin/bash

# Run UI Inspection Test
# This script runs the UI inspection test and captures the output

echo "🔍 Running FindMy UI Inspection Test..."
echo ""
echo "⚠️  IMPORTANT: Make sure your device is UNLOCKED!"
echo ""

# Device ID
DEVICE_ID="00008110-001E64343483801E"

# Output file
OUTPUT_FILE="findmy_ui_inspection_output.txt"

echo "📱 Running test on device..."
echo "   Output will be saved to: $OUTPUT_FILE"
echo ""

# Run the test and capture output
xcodebuild test \
    -project FindMeAppCTLTest.xcodeproj \
    -scheme FindMeAppCTLTest \
    -destination "platform=iOS,id=$DEVICE_ID" \
    -only-testing:FindMeAppCTLTestUITests/testInspectFindMyAppUI \
    2>&1 | tee "$OUTPUT_FILE"

echo ""
echo "✅ Test completed!"
echo ""
echo "📄 Output saved to: $OUTPUT_FILE"
echo ""
echo "To view the UI inspection results:"
echo "  grep -A 500 'FINDMY APP UI INSPECTION' $OUTPUT_FILE | less"
echo ""
echo "Or open in your editor:"
echo "  open $OUTPUT_FILE"
