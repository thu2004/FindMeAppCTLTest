# Running Tests on Real iOS Device

## Your Device
- **Name**: Chi Thu – iPhone (180)
- **iOS Version**: 26.1
- **Device ID**: `00008110-001E64343483801E`

## Prerequisites

### 1. Device Setup
- ✅ Device is connected via USB or Wi-Fi
- ✅ Device is unlocked
- ✅ Device is trusted (check "Trust This Computer" prompt)
- ✅ Developer Mode is enabled on device (Settings → Privacy & Security → Developer Mode)

### 2. Xcode Setup
- ✅ Xcode is installed and up to date
- ✅ iOS 26.0+ SDK is installed
- ✅ Your Apple Developer account is configured in Xcode
- ✅ Signing certificate is configured for the test target

### 3. Permissions
- ⚠️ **Important**: UI testing requires accessibility permissions
- The test app needs permission to control the FindMy app
- You may need to grant permissions in Settings → Privacy & Security → Accessibility

## Method 1: Using Xcode (Recommended)

### Step 1: Open Project
```bash
open FindMeAppCTLTest.xcodeproj
```
Or the project is already open.

### Step 2: Select Your Device
1. In Xcode, click the device selector (top toolbar)
2. Select **"Chi Thu – iPhone (180)"** from the list
3. Ensure the scheme is set to **"FindMeAppCTLTest"**

### Step 3: Configure Signing
1. Select the project in the navigator
2. Select the **"FindMeAppCTLTestUITests"** target
3. Go to **"Signing & Capabilities"** tab
4. Select your **Team** from the dropdown
5. Ensure **"Automatically manage signing"** is checked
6. Xcode will provision the app automatically

### Step 4: Run Tests
**Option A: Run All UI Tests**
- Press `Cmd + U` to run all tests

**Option B: Run Specific Test**
1. Open `FindMeAppCTLTestUITests.swift`
2. Click the diamond icon next to the test method (e.g., `testNavigateThroughAllTabs`)
3. The test will run on your device

**Option C: Test Navigator**
1. Press `Cmd + 6` to open Test Navigator
2. Find `FindMeAppCTLTestUITests`
3. Click the play button next to any test

### Step 5: Monitor Test Execution
- Watch your iPhone screen - you'll see:
  - FindMy app launching
  - Tabs being clicked automatically
  - 5-second pauses on each tab
- Test results appear in Xcode's test navigator

## Method 2: Command Line

### Run All UI Tests
```bash
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests
```

### Run Specific Test
```bash
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests/testNavigateThroughAllTabs
```

### Using the Helper Script
```bash
# Run all UI tests
./run_tests_on_device.sh

# Run specific test
./run_tests_on_device.sh testNavigateThroughAllTabs
```

## Available Tests

1. **testNavigateThroughAllTabs** - Complete tab navigation cycle
   - Tests: Devices → Items → Me → Devices
   - 5 seconds wait on each tab
   - Captures screenshots

2. **testTabNavigationSequence** - Quick navigation test
   - Tests all three tabs with method chaining
   - 5 seconds wait on each tab

3. **testIndividualTabDevices** - Devices tab only
4. **testIndividualTabItems** - Items tab only
5. **testIndividualTabMe** - Me tab only

## Troubleshooting

### Issue: "iOS 26.0 must be installed"
**Solution**: The project needs iOS 26.0 SDK support
1. Open project in Xcode
2. Select project → Targets → FindMeAppCTLTestUITests
3. Go to "Build Settings"
4. Search for "iOS Deployment Target"
5. Ensure it's set to a compatible version

### Issue: "Failed to build"
**Solution**: Check code signing
1. Select the project in Xcode
2. Select each target (FindMeAppCTLTest, FindMeAppCTLTestTests, FindMeAppCTLTestUITests)
3. Go to "Signing & Capabilities"
4. Select your Team
5. Let Xcode provision automatically

### Issue: "Could not launch FindMy app"
**Solution**: Accessibility permissions needed
1. Run the test once (it may fail)
2. On your iPhone: Settings → Privacy & Security → Accessibility
3. Enable the test runner app
4. Run the test again

### Issue: "Device not found"
**Solution**: Check device connection
```bash
# List all devices
xcrun xctrace list devices

# Verify your device appears in the list
```

### Issue: "Developer Mode not enabled"
**Solution**: Enable Developer Mode
1. On iPhone: Settings → Privacy & Security → Developer Mode
2. Toggle ON
3. Restart device if prompted
4. Confirm when prompted

### Issue: "Untrusted Developer"
**Solution**: Trust the developer certificate
1. On iPhone: Settings → General → VPN & Device Management
2. Find your developer certificate
3. Tap "Trust"

## What to Expect

When tests run on your device:

1. **Build Phase** (~30-60 seconds)
   - Xcode compiles the test target
   - Installs test runner on device
   - Provisions signing certificates

2. **Test Execution** (~30 seconds per test)
   - FindMy app launches automatically
   - You'll see tabs being clicked
   - 5-second pauses between actions
   - Screenshots are captured

3. **Results**
   - Green checkmark ✅ = Test passed
   - Red X ❌ = Test failed
   - View detailed logs in Xcode's Report Navigator (Cmd + 9)

## Best Practices

1. **Keep Device Unlocked**: Tests may fail if device locks during execution
2. **Don't Interact**: Let the test run automatically without touching the device
3. **Stable Connection**: Use USB cable for most reliable connection
4. **Close Other Apps**: Ensure FindMy app can launch cleanly
5. **Check Permissions**: Grant all necessary permissions before running tests

## Quick Reference

```bash
# Open project in Xcode
open FindMeAppCTLTest.xcodeproj

# List available devices
xcrun xctrace list devices

# Run specific test on device
./run_tests_on_device.sh testNavigateThroughAllTabs

# View test results
# In Xcode: Cmd + 9 (Report Navigator)
```

## Notes

- Tests interact with the **system FindMy app** (bundle ID: `com.apple.findmy`)
- Your device must have FindMy app installed (it's built-in on iOS)
- Tests use XCTest UI automation framework
- Screenshots are saved in test results bundle
- Test execution time: ~30 seconds per test

## Support

If you encounter issues:
1. Check Xcode console for detailed error messages
2. Verify device appears in Xcode's device list
3. Ensure all prerequisites are met
4. Try running on simulator first to verify tests work
5. Check that FindMy app is accessible on the device
