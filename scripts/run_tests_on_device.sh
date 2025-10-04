#!/bin/bash

# Run UI Tests on Real iOS Device
# Usage: ./run_tests_on_device.sh [test_name]

set -e

PROJECT="FindMeAppCTLTest.xcodeproj"
SCHEME="FindMeAppCTLTest"

# Your device ID
DEVICE_ID="00008110-001E64343483801E"
DEVICE_NAME="Chi Thu – iPhone (180)"

echo "🔍 Running tests on real device: $DEVICE_NAME"
echo ""

# Check if specific test is provided
if [ -n "$1" ]; then
    TEST_NAME="$1"
    echo "📱 Running specific test: $TEST_NAME"
    echo ""
    
    xcodebuild test \
        -project "$PROJECT" \
        -scheme "$SCHEME" \
        -destination "platform=iOS,id=$DEVICE_ID" \
        -only-testing:"FindMeAppCTLTestUITests/$TEST_NAME" \
        | xcpretty || true
else
    echo "📱 Running all UI tests"
    echo ""
    
    xcodebuild test \
        -project "$PROJECT" \
        -scheme "$SCHEME" \
        -destination "platform=iOS,id=$DEVICE_ID" \
        -only-testing:FindMeAppCTLTestUITests \
        | xcpretty || true
fi

echo ""
echo "✅ Test run completed"
