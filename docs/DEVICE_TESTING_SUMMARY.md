# Device Testing - Quick Summary

## Your Device
**Chi Thu – iPhone (180)** running iOS 26.1

## Quick Start (Xcode - Easiest Method)

### 1. Open Project
The project should already be open in Xcode. If not:
```bash
open FindMeAppCTLTest.xcodeproj
```

### 2. Select Your Device
- Click device selector in Xcode toolbar
- Choose **"Chi Thu – iPhone (180)"**

### 3. Configure Signing (First Time Only)
- Select project → **FindMeAppCTLTestUITests** target
- Go to **Signing & Capabilities**
- Select your **Team**
- Enable **"Automatically manage signing"**

### 4. Run Tests
Press **`Cmd + U`** to run all tests

Or click the ▶️ button next to any test method in the code.

## Quick Commands

```bash
# Run tab navigation test on your device
make test-device-tabs

# Run all UI tests on your device
make test-device

# Build for your device
make build-device

# List all devices
make list-devices
```

## What You'll See

When tests run on your iPhone:
1. ✅ FindMy app launches automatically
2. ✅ Tabs are clicked: Devices → Items → Me → Devices
3. ✅ 5-second pause on each tab
4. ✅ Screenshots captured
5. ✅ Results appear in Xcode

## Available Tests

1. **testNavigateThroughAllTabs** ⭐ Main test
   - Complete tab navigation cycle
   - 5 seconds on each tab
   - Screenshots captured

2. **testTabNavigationSequence**
   - Quick navigation test
   - Method chaining demo

3. **testIndividualTabDevices**
4. **testIndividualTabItems**
5. **testIndividualTabMe**

## Important Notes

⚠️ **Before First Run:**
- Device must be unlocked
- Developer Mode enabled (Settings → Privacy & Security → Developer Mode)
- Trust this computer (prompt appears when connecting)

⚠️ **During Test:**
- Keep device unlocked
- Don't touch the device
- Let tests run automatically

⚠️ **Permissions:**
- Tests may request accessibility permissions
- Grant permissions in Settings → Privacy & Security → Accessibility

## Troubleshooting

### "iOS 26.0 must be installed"
→ Use Xcode to run tests (it handles this automatically)
→ Or check project deployment target settings

### "Failed to build" / Signing errors
→ Configure signing in Xcode (see step 3 above)

### "Could not launch FindMy"
→ Grant accessibility permissions on device

### Device not found
```bash
make list-devices  # Verify device is connected
```

## Full Documentation

See **RUN_ON_DEVICE.md** for complete instructions and troubleshooting.

## Test Execution Time

- Build: ~30-60 seconds (first time)
- Each test: ~30 seconds
- Total for all tests: ~3-5 minutes

## Success Indicators

✅ Green checkmarks in Xcode Test Navigator
✅ "Test Succeeded" in console output
✅ Screenshots in test results
✅ No red errors in console

---

**Recommended**: Use Xcode GUI for first run, then use command line for automation.
