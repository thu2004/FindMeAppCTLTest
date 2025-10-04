# Xcode Beta Usage Guide

## Overview

This project can be built and tested with either Xcode Stable or Xcode Beta. This guide explains how to switch between versions.

## Current Setup

You have both versions installed:
- **Xcode Stable:** `/Applications/Xcode.app`
- **Xcode Beta:** `/Applications/Xcode-beta.app`

## Quick Commands

### Check Current Xcode Version
```bash
make xcode-version
```

### Switch to Xcode Beta
```bash
make switch-xcode-beta
# Or directly:
./switch_to_xcode_beta.sh
```

### Switch to Xcode Stable
```bash
make switch-xcode-stable
# Or directly:
./switch_to_xcode_stable.sh
```

## Switching to Xcode Beta

### Method 1: Using Make (Recommended)
```bash
make switch-xcode-beta
```

### Method 2: Using Script
```bash
./switch_to_xcode_beta.sh
```

### Method 3: Manual Command
```bash
sudo xcode-select -s /Applications/Xcode-beta.app/Contents/Developer
```

**Note:** All methods require your password (sudo access).

## After Switching to Xcode Beta

### 1. Verify the Switch
```bash
make xcode-version
```

Expected output:
```
Current Xcode path:
/Applications/Xcode-beta.app/Contents/Developer

Xcode version:
Xcode 16.x (or higher)
Build version XXXXX
```

### 2. Clean Build (Recommended)
```bash
make clean
```

### 3. Rebuild Project
```bash
make build
```

### 4. Run Tests
```bash
# On simulator
make test-ui

# On real device
make test-device-tabs
```

## Opening Project in Xcode Beta

### From Command Line
```bash
open -a "Xcode-beta" FindMeAppCTLTest.xcodeproj
```

### From Finder
1. Right-click on `FindMeAppCTLTest.xcodeproj`
2. Select "Open With" → "Xcode-beta"

### Set as Default (Optional)
1. Right-click on `FindMeAppCTLTest.xcodeproj`
2. Select "Get Info"
3. Under "Open with:", select "Xcode-beta.app"
4. Click "Change All..." (optional)

## Benefits of Using Xcode Beta

### Advantages
- ✅ Latest iOS SDK versions
- ✅ New Swift language features
- ✅ Latest Xcode tools and improvements
- ✅ Better device compatibility (iOS 26.1 support)
- ✅ Preview upcoming features

### Considerations
- ⚠️ May have bugs (it's beta software)
- ⚠️ Some features might be unstable
- ⚠️ Documentation may be incomplete
- ⚠️ Can run alongside stable Xcode

## Switching Back to Stable

If you encounter issues with Xcode Beta:

```bash
make switch-xcode-stable
make clean
make build
```

## Project Compatibility

This project is compatible with both versions:
- ✅ Xcode Stable
- ✅ Xcode Beta

All tests and build commands work with either version.

## Common Issues

### Issue: "Command line tools not found"
**Solution:**
```bash
# After switching, run:
sudo xcodebuild -runFirstLaunch
```

### Issue: "Simulator not available"
**Solution:**
Xcode Beta may have different simulator versions. List available simulators:
```bash
make list-simulators
```

Update Makefile if needed to use a simulator available in Beta.

### Issue: "Build fails after switching"
**Solution:**
```bash
# Clean derived data
make clean
rm -rf ~/Library/Developer/Xcode/DerivedData/FindMeAppCTLTest-*

# Rebuild
make build
```

### Issue: "Device not recognized"
**Solution:**
Xcode Beta may need device support files:
1. Connect device
2. Open Xcode Beta
3. Wait for "Preparing device" to complete
4. Try again

## Best Practices

### 1. Clean Build After Switching
Always clean build when switching Xcode versions:
```bash
make clean
make build
```

### 2. Check Version Before Building
Verify you're using the intended Xcode version:
```bash
make xcode-version
```

### 3. Keep Both Versions
Don't uninstall stable Xcode - keep both for flexibility.

### 4. Use Beta for Testing
Use Xcode Beta to test compatibility with upcoming iOS versions.

### 5. Use Stable for Production
Use stable Xcode for final builds and App Store submissions.

## Automation

### Build with Specific Xcode Version

**Using Xcode Beta:**
```bash
make switch-xcode-beta
make build
```

**Using Xcode Stable:**
```bash
make switch-xcode-stable
make build
```

### Test with Specific Xcode Version

**Beta:**
```bash
make switch-xcode-beta
make test-device-tabs
```

**Stable:**
```bash
make switch-xcode-stable
make test-ui
```

## CI/CD Considerations

If using CI/CD, specify Xcode version in your pipeline:

```yaml
# Example for GitHub Actions
- name: Select Xcode Beta
  run: sudo xcode-select -s /Applications/Xcode-beta.app/Contents/Developer

- name: Build and Test
  run: make test-ui
```

## Troubleshooting Commands

```bash
# Check current Xcode
xcode-select -p

# List all Xcode installations
mdfind "kMDItemCFBundleIdentifier == 'com.apple.dt.Xcode'"

# Reset Xcode command line tools
sudo xcode-select --reset

# Accept Xcode license (if needed)
sudo xcodebuild -license accept
```

## Quick Reference

| Task | Command |
|------|---------|
| Check version | `make xcode-version` |
| Switch to Beta | `make switch-xcode-beta` |
| Switch to Stable | `make switch-xcode-stable` |
| Clean build | `make clean` |
| Build project | `make build` |
| Run tests | `make test-ui` or `make test-device-tabs` |
| Open in Beta | `open -a "Xcode-beta" FindMeAppCTLTest.xcodeproj` |

## Support

For Xcode Beta issues:
- Check Xcode Beta release notes
- Visit Apple Developer Forums
- File feedback via Feedback Assistant

For project-specific issues:
- Check `docs/TROUBLESHOOTING.md`
- Verify Xcode version with `make xcode-version`
- Try switching back to stable Xcode

---

**Note:** Switching Xcode versions is system-wide and affects all projects. Remember to switch back if needed for other projects.
