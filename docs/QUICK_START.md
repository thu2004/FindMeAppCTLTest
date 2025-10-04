# Quick Start Guide

## 🎯 Project Overview

**FindMeAppCTLTest** is a UI testing project for Apple's built-in **FindMy** app on iOS.

## ✅ Automatic File Management

Your project uses **PBXFileSystemSynchronizedRootGroup**, which means:
- ✅ All `.swift` files in target folders are **automatically included**
- ✅ No manual "Add Files to Project" needed
- ✅ Just create files and they're ready to use

## 📁 Project Structure

```
FindMeAppCTLTest/
├── FindMeAppCTLTestUITests/       # UI Test Target (auto-synced)
│   ├── TestContext.swift          # Singleton for test context
│   ├── PageObjects/               # Page Object pattern
│   │   ├── BasePage.swift         # Base class for all pages
│   │   └── FindMyMainPage.swift   # FindMy main screen
│   ├── FindMeAppCTLTestUITests.swift
│   └── FindMeAppCTLTestUITestsLaunchTests.swift
```

## 🚀 Quick Commands

### Using Make (Recommended)

```bash
# Show all available commands
make help

# Verify setup
make verify

# Build project
make build

# Run UI tests
make test-ui

# Run all tests
make test

# Clean build
make clean

# Open in Xcode
make open
```

### Using xcodebuild Directly

```bash
# Build
xcodebuild build -project FindMeAppCTLTest.xcodeproj -scheme FindMeAppCTLTest -destination 'platform=iOS Simulator,name=iPhone 15'

# Run UI tests
xcodebuild test -project FindMeAppCTLTest.xcodeproj -scheme FindMeAppCTLTest -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:FindMeAppCTLTestUITests
```

## 📝 Writing Tests

### Example Test Using Page Objects

```swift
@MainActor
func testNavigateToDevices() throws {
    // Launch FindMy app
    TestContext.shared.launchFindMyApp()
    let app = TestContext.shared.getFindMyApp()
    
    // Use Page Object pattern
    let mainPage = FindMyMainPage(app: app)
    
    // Verify and interact
    mainPage.verifyMainPageIsDisplayed()
    mainPage.navigateToDevicesTab()
    mainPage.verifyDevicesTabIsSelected()
}
```

### Method Chaining

```swift
FindMyMainPage(app: app)
    .verifyMainPageIsDisplayed()
    .navigateToItemsTab()
    .verifyItemsTabIsSelected()
```

## 🏗️ Creating New Page Objects

1. Create a new file in `FindMeAppCTLTestUITests/PageObjects/`
2. Inherit from `BasePage`
3. Define element identifiers
4. Add action and verification methods

Example:
```swift
import XCTest

class DevicesListPage: BasePage {
    private struct Identifiers {
        static let deviceCell = "device_cell"
    }
    
    var deviceCell: XCUIElement {
        return element(withIdentifier: Identifiers.deviceCell)
    }
    
    func verifyDevicesListIsDisplayed() {
        verifyElementExists(deviceCell)
    }
}
```

## 📚 Documentation

All documentation is in the `docs/` folder:
- **docs/UI_TESTS_README.md** - Main test documentation
- **docs/RESOURCES.md** - XCTest framework resources
- **docs/PAGE_OBJECTS_README.md** - Page Object pattern guide
- **PROJECT_SETUP.md** - Detailed setup information
- **QUICK_START.md** - This file
- **RUN_ON_DEVICE.md** - Device testing guide

## 🔧 Optional: XcodeGen

If you want explicit project file management:

```bash
# Install XcodeGen
make install-xcodegen

# Generate project from project.yml
make generate-project
```

## ⚠️ Important Notes

1. **FindMy Bundle ID**: `com.apple.findmy`
2. **Test Target**: Tests run against the system FindMy app, not your app
3. **Permissions**: May need to grant accessibility permissions for UI testing
4. **Simulator**: Ensure FindMy app is available on the simulator

## 🐛 Troubleshooting

### "No such module 'XCTest'" errors
- These are temporary SourceKit indexing issues
- Files will compile correctly
- Try: Clean Build Folder (Cmd+Shift+K) in Xcode

### Files not compiling
- Verify files are in the correct directory
- Check file extensions are `.swift`
- Run `make clean` and rebuild

### Tests can't find FindMy app
- Ensure FindMy is installed on the simulator
- Check bundle identifier: `com.apple.findmy`
- Grant necessary permissions

## 📞 Next Steps

1. ✅ Run `make verify` to check setup
2. ✅ Run `make test-ui` to run existing tests
3. ✅ Create new page objects for different screens
4. ✅ Write tests for FindMy functionality
5. ✅ Refer to documentation as needed

## 🎓 Key Concepts

- **TestContext**: Singleton managing app instance and test data
- **Page Objects**: Encapsulate UI elements and interactions
- **BasePage**: Common functionality for all page objects
- **Auto-sync**: Files automatically included in build

Happy Testing! 🚀
