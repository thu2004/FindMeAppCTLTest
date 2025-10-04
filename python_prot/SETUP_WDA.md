# WebDriverAgent Setup for Real iOS Device

WebDriverAgent (WDA) is required for Appium to control iOS devices. Follow these steps to set it up.

## Problem
Error: `xcodebuild failed with code 65` - WebDriverAgent cannot build/launch on your device.

## Solution

### Step 1: Find Your Apple Developer Team ID

Run this command to find your Team ID:

```bash
security find-identity -v -p codesigning
```

Look for your Apple Developer certificate and note the Team ID (usually a 10-character string like `ABCD123456`).

### Step 2: Update the Test Script

Edit `appium_test.py` and replace these placeholders:

```python
options.xcode_org_id = 'YOUR_TEAM_ID'  # Replace with your actual Team ID
options.updated_wda_bundle_id = 'com.yourteam.WebDriverAgentRunner'  # Replace yourteam
```

**Example:**
```python
options.xcode_org_id = 'ABCD123456'
options.updated_wda_bundle_id = 'com.apple.WebDriverAgentRunner'
```

### Step 3: Build WebDriverAgent Manually (First Time Only)

1. **Locate WebDriverAgent project:**
   ```bash
   cd ~/.appium/node_modules/appium-xcuitest-driver/node_modules/appium-webdriveragent
   ```

2. **Open in Xcode:**
   ```bash
   open WebDriverAgent.xcodeproj
   ```

3. **Configure signing:**
   - Select `WebDriverAgentRunner` target
   - Go to "Signing & Capabilities"
   - Check "Automatically manage signing"
   - Select your Team from dropdown
   - Change Bundle Identifier to something unique (e.g., `com.yourname.WebDriverAgentRunner`)

4. **Build for your device:**
   - Select your iPhone from the device dropdown
   - Product → Build (⌘B)
   - If successful, Product → Test (⌘U)

5. **Trust the app on your iPhone:**
   - On your iPhone: Settings → General → VPN & Device Management
   - Trust your developer certificate

### Step 4: Alternative - Use Simulator Instead

If real device setup is too complex, use iOS Simulator:

```python
# Change these lines in appium_test.py:
options.platform_name = 'iOS'
options.platform_version = '17.4'  # Your iOS version
options.device_name = 'iPhone 15 Pro'  # Simulator name
# Remove or comment out:
# options.udid = '00008110-001E64343483801E'
# options.xcode_org_id = ...
# options.updated_wda_bundle_id = ...
```

### Step 5: Verify Setup

Run the test again:

```bash
python appium_test.py
```

## Common Issues

### Issue: "No provisioning profile found"
**Solution:** In Xcode, ensure "Automatically manage signing" is enabled and a valid Team is selected.

### Issue: "Code signing is required"
**Solution:** You need an Apple Developer account (free or paid) to sign apps for real devices.

### Issue: "Device is locked"
**Solution:** Unlock your iPhone and keep it unlocked during the test.

### Issue: Still getting code 65
**Solution:** Check Appium server logs with `showXcodeLog: true` capability (already added) to see detailed build errors.

## Quick Fix: Use Your XCUITest Project Instead

Since you already have a working XCUITest project (`FindMeAppCTLTest`), you can use that for testing instead of Appium. Your Swift tests are already configured and working!

## Resources

- [Appium XCUITest Real Device Setup](https://appium.github.io/appium-xcuitest-driver/latest/preparation/real-device-config/)
- [WebDriverAgent Documentation](https://github.com/appium/WebDriverAgent)
