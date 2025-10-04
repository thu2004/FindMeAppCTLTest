#!/bin/bash
# Script to build and configure WebDriverAgent for real device testing

set -e

echo "🔧 Building WebDriverAgent for your iPhone..."
echo ""

# Configuration
TEAM_ID="5C489RHX7L"
BUNDLE_ID="com.chithule.WebDriverAgentRunner"
DEVICE_UDID="00008110-001E64343483801E"
WDA_PATH="$HOME/.appium/node_modules/appium-xcuitest-driver/node_modules/appium-webdriveragent"

# Check if WDA exists
if [ ! -d "$WDA_PATH" ]; then
    echo "❌ WebDriverAgent not found at: $WDA_PATH"
    echo "Please ensure Appium XCUITest driver is installed"
    exit 1
fi

echo "📂 WebDriverAgent location: $WDA_PATH"
cd "$WDA_PATH"

echo ""
echo "🏗️  Building WebDriverAgentRunner..."
echo ""

# Build WebDriverAgentRunner for the device
xcodebuild \
    -project WebDriverAgent.xcodeproj \
    -scheme WebDriverAgentRunner \
    -destination "id=$DEVICE_UDID" \
    -allowProvisioningUpdates \
    DEVELOPMENT_TEAM="$TEAM_ID" \
    PRODUCT_BUNDLE_IDENTIFIER="$BUNDLE_ID" \
    CODE_SIGN_STYLE=Automatic \
    clean build-for-testing

echo ""
echo "✅ WebDriverAgent built successfully!"
echo ""
echo "📱 Next steps:"
echo "1. On your iPhone, go to: Settings → General → VPN & Device Management"
echo "2. Trust the developer certificate for 'Chi Thu Le'"
echo "3. Run your Appium test: python appium_test.py"
echo ""
