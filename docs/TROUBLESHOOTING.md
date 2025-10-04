# Troubleshooting Guide

## Build Errors

### ✅ FIXED: "Multiple commands produce README.md"

**Error Message:**
```
Multiple commands produce '/Users/.../FindMeAppCTLTestUITests-Runner.app/.../README.md'
```

**Cause:**
Xcode's `PBXFileSystemSynchronizedRootGroup` auto-sync feature was trying to include all files in the test target folder, including multiple `.md` documentation files.

**Solution:**
Moved all documentation files outside the test target folders to a dedicated `docs/` folder.

**New Structure:**
```
FindMeAppCTLTest/
├── docs/                          # All documentation (outside build targets)
│   ├── README.md
│   ├── UI_TESTS_README.md
│   ├── RESOURCES.md
│   └── PAGE_OBJECTS_README.md
│
└── FindMeAppCTLTestUITests/       # Only Swift code files
    ├── TestContext.swift
    ├── PageObjects/
    │   ├── BasePage.swift
    │   └── FindMyMainPage.swift
    └── *.swift
```

**Status:** ✅ Build now succeeds

---

## Common Issues

### "No such module 'XCTest'"

**Symptom:** IDE shows red errors on `import XCTest`

**Cause:** SourceKit indexing issue - files aren't recognized as part of the Xcode project yet

**Solution:**
1. These are temporary IDE errors
2. Files will compile correctly (auto-sync includes them)
3. Try: Product → Clean Build Folder (Cmd+Shift+K)
4. Or restart Xcode

**Status:** Cosmetic issue - doesn't affect compilation

---

### "iOS 26.0 must be installed"

**Symptom:** Build fails when targeting real device

**Cause:** Project requires iOS 26.0 SDK

**Solution:**
1. Use Xcode to run tests (handles SDK automatically)
2. Or check deployment target: Project Settings → Targets → Build Settings → iOS Deployment Target

**Workaround:** Run tests through Xcode GUI instead of command line

---

### "Failed to build" / Code Signing Errors

**Symptom:** Build fails with signing errors when targeting device

**Cause:** Code signing not configured

**Solution:**
1. Open project in Xcode
2. Select each target (FindMeAppCTLTest, FindMeAppCTLTestTests, FindMeAppCTLTestUITests)
3. Go to "Signing & Capabilities" tab
4. Select your Team
5. Enable "Automatically manage signing"

---

### "Could not launch FindMy app"

**Symptom:** Tests fail to launch FindMy app

**Cause:** Missing accessibility permissions

**Solution:**
1. Run test once (may fail)
2. On device: Settings → Privacy & Security → Accessibility
3. Enable the test runner app
4. Run test again

---

### "Device not found"

**Symptom:** xcodebuild can't find device

**Cause:** Device not connected or not trusted

**Solution:**
```bash
# Check connected devices
xcrun xctrace list devices

# Verify your device appears
make list-devices
```

Ensure:
- Device is connected via USB or Wi-Fi
- Device is unlocked
- "Trust This Computer" accepted
- Developer Mode enabled

---

### "Developer Mode not enabled"

**Symptom:** Can't run tests on device

**Cause:** Developer Mode disabled on iOS device

**Solution:**
1. On iPhone: Settings → Privacy & Security → Developer Mode
2. Toggle ON
3. Restart device if prompted
4. Confirm when prompted

---

### Tests Timeout or Hang

**Symptom:** Tests start but never complete

**Cause:** Various - element not found, app not launching, permissions

**Solution:**
1. Check device is unlocked
2. Verify FindMy app is installed
3. Check test logs in Xcode (Cmd+9)
4. Increase timeout in TestContext:
   ```swift
   testConfiguration["defaultTimeout"] = 30.0
   ```

---

### Simulator Not Available

**Symptom:** "Unable to load simulator devices"

**Cause:** CoreSimulator version mismatch

**Solution:**
1. Update Xcode to latest version
2. Update macOS if needed
3. Or use real device instead:
   ```bash
   make test-device
   ```

---

## Verification Commands

### Check Setup
```bash
make verify
```

### List Available Devices
```bash
make list-devices
```

### List Available Simulators
```bash
make list-simulators
```

### Clean Build
```bash
make clean
```

### Build Only (No Tests)
```bash
make build
```

---

## Getting Help

### Check Logs
1. In Xcode: View → Navigators → Report Navigator (Cmd+9)
2. Select latest test run
3. Review detailed logs

### Verify File Structure
```bash
# Check test files exist
ls -la FindMeAppCTLTestUITests/
ls -la FindMeAppCTLTestUITests/PageObjects/

# Check documentation moved
ls -la docs/
```

### Build from Clean State
```bash
make clean
make build
```

### Test on Simulator First
```bash
# Easier to debug than device
make test-ui
```

---

## Known Limitations

1. **System App Testing**: FindMy is a system app - some features may be restricted
2. **Permissions**: May require manual permission grants on first run
3. **iOS Version**: Device must run compatible iOS version
4. **Xcode Version**: Must have compatible Xcode/SDK versions

---

## Debug Tips

### Enable Verbose Logging
```bash
make test-verbose
```

### Run Single Test
```bash
# Easier to debug
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  -only-testing:FindMeAppCTLTestUITests/testIndividualTabDevices
```

### Check Element Identifiers
If tests can't find elements:
1. Use Xcode's Accessibility Inspector
2. Record UI test to see actual identifiers
3. Update page object identifiers accordingly

### Screenshot on Failure
Tests automatically capture screenshots - check test results bundle

---

## Contact & Support

For persistent issues:
1. Check all documentation in `docs/` folder
2. Review Xcode console output
3. Verify all prerequisites met
4. Try simulator before device
5. Clean build and retry
