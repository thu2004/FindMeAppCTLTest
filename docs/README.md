# FindMeAppCTLTest Documentation

This folder contains all documentation for the FindMeAppCTLTest project.

## Documentation Files

### Getting Started
- **[QUICK_START.md](QUICK_START.md)** - Quick start guide
- **[PROJECT_SETUP.md](PROJECT_SETUP.md)** - Detailed project setup
- **[README.md](README.md)** - This file

### Test Documentation
- **[UI_TESTS_README.md](UI_TESTS_README.md)** - Main UI tests documentation
  - Test structure and organization
  - TestContext singleton usage
  - Best practices
  - Future test areas

- **[DEVICE_TESTS.md](DEVICE_TESTS.md)** - Device functionality tests
  - Swift and Python implementations
  - Play Sound, Directions, Location tests
  - Chi's Laptop specific tests
  - Running device tests

- **[PAGE_OBJECTS_README.md](PAGE_OBJECTS_README.md)** - Page Object pattern guide
  - Design pattern overview
  - BasePage functionality
  - Creating new page objects
  - Usage examples
  - Naming conventions

- **[PAGE_OBJECTS_UPDATED.md](PAGE_OBJECTS_UPDATED.md)** - Page objects update summary
  - What was discovered from UI inspection
  - Updated identifiers
  - Localization notes

- **[RESOURCES.md](RESOURCES.md)** - XCTest framework resources
  - Official Apple documentation links
  - XCTest components reference
  - Project-specific resources

### Running Tests
- **[RUN_INDIVIDUAL_TESTS.md](RUN_INDIVIDUAL_TESTS.md)** - How to run individual tests
  - Using Xcode (recommended)
  - Command line options
  - Available tests reference

- **[RUN_ON_DEVICE.md](RUN_ON_DEVICE.md)** - Running tests on real devices
  - Complete device setup guide
  - Troubleshooting device issues

- **[DEVICE_TESTING_SUMMARY.md](DEVICE_TESTING_SUMMARY.md)** - Device testing quick reference

### UI Inspection & Updates
- **[UI_INSPECTION_WORKFLOW.md](UI_INSPECTION_WORKFLOW.md)** - Complete UI inspection workflow
  - When to run inspection
  - How to update page objects
  - Workflow best practices

- **[UI_INSPECTION_GUIDE.md](UI_INSPECTION_GUIDE.md)** - UI inspection test guide
  - Running the inspection test
  - Interpreting results

- **[UI_INSPECTION_SUMMARY.md](UI_INSPECTION_SUMMARY.md)** - Quick reference for UI inspection

- **[FINDMY_UI_STRUCTURE.md](FINDMY_UI_STRUCTURE.md)** - FindMy app UI structure
  - Actual UI hierarchy
  - Element identifiers
  - Localization notes

### Xcode Configuration
- **[XCODE_BETA_GUIDE.md](XCODE_BETA_GUIDE.md)** - Using Xcode Beta
  - How to switch Xcode versions
  - Beta-specific features

- **[XCODE_BETA_SWITCHED.md](XCODE_BETA_SWITCHED.md)** - Xcode Beta switch summary

### Troubleshooting & Fixes
- **[TROUBLESHOOTING.md](TROUBLESHOOTING.md)** - Common issues and solutions
- **[BUILD_FIX_SUMMARY.md](BUILD_FIX_SUMMARY.md)** - Build error fixes

### Build & Automation
- **[../Makefile](../Makefile)** - Build commands and automation
- **[../scripts/verify_setup.sh](../scripts/verify_setup.sh)** - Setup verification script
- **[../scripts/run_tests_on_device.sh](../scripts/run_tests_on_device.sh)** - Device testing script
- **[../scripts/run_ui_inspection.sh](../scripts/run_ui_inspection.sh)** - UI inspection script
- **[../scripts/switch_to_xcode_beta.sh](../scripts/switch_to_xcode_beta.sh)** - Switch to Xcode Beta
- **[../scripts/switch_to_xcode_stable.sh](../scripts/switch_to_xcode_stable.sh)** - Switch to Xcode Stable
- **[../project.yml](../project.yml)** - Optional XcodeGen configuration

## Quick Links

### Getting Started
1. Read [QUICK_START.md](../QUICK_START.md)
2. Review [UI_TESTS_README.md](UI_TESTS_README.md)
3. Check [PAGE_OBJECTS_README.md](PAGE_OBJECTS_README.md)

### Running Tests
- Simulator: `make test-ui`
- Real device: `make test-device-tabs`
- See [RUN_ON_DEVICE.md](../RUN_ON_DEVICE.md) for details

### Development
- Creating page objects: [PAGE_OBJECTS_README.md](PAGE_OBJECTS_README.md)
- XCTest reference: [RESOURCES.md](RESOURCES.md)
- Test patterns: [UI_TESTS_README.md](UI_TESTS_README.md)

## Project Structure

```
FindMeAppCTLTest/
├── docs/                          # Documentation (this folder)
│   ├── README.md                  # This file
│   ├── QUICK_START.md             # Quick start guide
│   ├── PROJECT_SETUP.md           # Setup documentation
│   ├── UI_TESTS_README.md         # UI tests documentation
│   ├── PAGE_OBJECTS_README.md     # Page Object pattern guide
│   ├── RUN_ON_DEVICE.md           # Device testing guide
│   ├── UI_INSPECTION_WORKFLOW.md  # UI inspection workflow
│   └── [18 documentation files]
│
├── FindMeAppCTLTestUITests/       # UI Test Target
│   ├── TestContext.swift          # Test context singleton
│   ├── PageObjects/               # Page Object classes
│   │   ├── BasePage.swift         # Base page object
│   │   └── FindMyMainPage.swift   # FindMy main screen
│   ├── FindMeAppCTLTestUITests.swift
│   └── FindMyUIInspectionTests.swift
│
├── scripts/                       # Automation scripts
│   ├── verify_setup.sh            # Setup verification
│   ├── run_tests_on_device.sh     # Device testing
│   ├── run_ui_inspection.sh       # UI inspection
│   ├── switch_to_xcode_beta.sh    # Switch to Xcode Beta
│   └── switch_to_xcode_stable.sh  # Switch to Xcode Stable
│
├── tmp/                           # Temporary files (gitignored)
├── inspections/                   # UI inspection logs (gitignored)
├── Makefile                       # Build automation
├── project.yml                    # XcodeGen configuration
└── FindMeAppCTLTest.xcodeproj/    # Xcode project
```

## Key Concepts

### TestContext Singleton
Manages test context, app instance, and shared data across tests.

### Page Object Pattern
Encapsulates UI elements and interactions for maintainable tests.

### Auto-Sync Files
Project uses PBXFileSystemSynchronizedRootGroup - Swift files are automatically included.

## Support

For issues or questions:
1. Check relevant documentation file
2. Review troubleshooting sections
3. Verify setup with `make verify`
4. Check Xcode console for errors
