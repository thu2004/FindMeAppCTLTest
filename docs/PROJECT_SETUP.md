# Project Setup and Configuration

## Automatic File Discovery

This project uses Xcode's **PBXFileSystemSynchronizedRootGroup** feature, which means:

✅ **Files are automatically discovered and included** in the build
✅ No manual "Add Files to Project" needed
✅ Any Swift files in the target folders are automatically compiled

### How It Works

The following directories are synchronized:
- `FindMeAppCTLTest/` - Main app target
- `FindMeAppCTLTestTests/` - Unit tests target
- `FindMeAppCTLTestUITests/` - UI tests target

When you create a new `.swift` file in any of these directories, Xcode automatically:
1. Detects the file
2. Adds it to the appropriate target
3. Includes it in the build

### Verifying File Inclusion

To verify files are included:
1. Open the project in Xcode
2. Select the target (e.g., `FindMeAppCTLTestUITests`)
3. Go to "Build Phases" → "Compile Sources"
4. All `.swift` files in the directory should be listed

### Current UI Test Files

All files in `FindMeAppCTLTestUITests/` are automatically included:
- `FindMeAppCTLTestUITests.swift`
- `FindMeAppCTLTestUITestsLaunchTests.swift`
- `TestContext.swift`
- `PageObjects/BasePage.swift`
- `PageObjects/FindMyMainPage.swift`

## Building the Project

### Command Line Build

```bash
# Build all targets
xcodebuild -project FindMeAppCTLTest.xcodeproj -scheme FindMeAppCTLTest

# Build and run tests
xcodebuild test -project FindMeAppCTLTest.xcodeproj -scheme FindMeAppCTLTest -destination 'platform=iOS Simulator,name=iPhone 15'

# Run only UI tests
xcodebuild test -project FindMeAppCTLTest.xcodeproj -scheme FindMeAppCTLTest -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:FindMeAppCTLTestUITests
```

### Xcode IDE

1. Open `FindMeAppCTLTest.xcodeproj` in Xcode
2. Select a simulator or device
3. Press `Cmd+U` to run tests
4. Or press `Cmd+B` to build

## Project Structure

```
FindMeAppCTLTest/
├── FindMeAppCTLTest/              # Main app (auto-synced)
│   ├── Assets.xcassets/
│   ├── ContentView.swift
│   └── FindMeAppCTLTestApp.swift
│
├── FindMeAppCTLTestTests/         # Unit tests (auto-synced)
│   └── FindMeAppCTLTestTests.swift
│
├── FindMeAppCTLTestUITests/       # UI tests (auto-synced)
│   ├── FindMeAppCTLTestUITests.swift
│   ├── FindMeAppCTLTestUITestsLaunchTests.swift
│   ├── TestContext.swift
│   ├── PageObjects/
│   │   ├── BasePage.swift
│   │   ├── FindMyMainPage.swift
│   │   └── README.md
│   ├── README.md
│   └── RESOURCES.md
│
├── FindMeAppCTLTest.xcodeproj/    # Xcode project
└── PROJECT_SETUP.md               # This file
```

## Troubleshooting

### SourceKit Errors in IDE

If you see "No such module 'XCTest'" errors in your IDE:
1. These are temporary SourceKit indexing issues
2. Files will compile correctly
3. Try: Product → Clean Build Folder (Cmd+Shift+K)
4. Or restart Xcode

### Files Not Compiling

If files aren't being compiled:
1. Verify files are in the correct directory
2. Check file extensions are `.swift`
3. Clean build folder and rebuild
4. Check Build Phases → Compile Sources in Xcode

### Test Target Not Finding Files

If tests can't find classes:
1. Ensure files are in `FindMeAppCTLTestUITests/` directory
2. Check that classes are not marked as `private`
3. Verify the target membership in Xcode

## XcodeGen Alternative (Optional)

If you prefer explicit project management, you can use XcodeGen:

### Install XcodeGen

```bash
brew install xcodegen
```

### Create project.yml

```yaml
name: FindMeAppCTLTest
options:
  bundleIdPrefix: com.yourcompany
targets:
  FindMeAppCTLTest:
    type: application
    platform: iOS
    sources:
      - FindMeAppCTLTest
    
  FindMeAppCTLTestTests:
    type: bundle.unit-test
    platform: iOS
    sources:
      - FindMeAppCTLTestTests
    dependencies:
      - target: FindMeAppCTLTest
  
  FindMeAppCTLTestUITests:
    type: bundle.ui-testing
    platform: iOS
    sources:
      - FindMeAppCTLTestUITests
    dependencies:
      - target: FindMeAppCTLTest
```

### Generate Project

```bash
xcodegen generate
```

## Notes

- The current setup with PBXFileSystemSynchronizedRootGroup is modern and efficient
- No additional tooling is required for file management
- Files are automatically included when created in the target directories
- This is the recommended approach for new Xcode projects
