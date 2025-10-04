# FindMy App UI Tests

## Overview
This test suite is designed to test Apple's built-in **FindMy** app on iOS using XCTest UI testing framework.

## TestContext Singleton

The `TestContext` class is a singleton that manages all test-related context data across test runs.

### Features
- **App Management**: Centralized FindMy app instance management
- **Configuration**: Shared test configuration settings
- **Test Data**: Store and retrieve test data across tests
- **Screenshots**: Manage captured screenshots
- **Metadata**: Track test execution metadata

### Usage Examples

#### Basic App Launch
```swift
func testBasicLaunch() throws {
    // Launch FindMy app using TestContext
    TestContext.shared.launchFindMyApp()
    let app = TestContext.shared.getFindMyApp()
    
    // Perform your test assertions
    XCTAssertTrue(app.exists)
}
```

#### Custom Launch Configuration
```swift
func testWithCustomConfig() throws {
    // Configure test settings
    TestContext.shared.testConfiguration["launchWaitTime"] = 3.0
    
    // Launch with custom arguments
    TestContext.shared.launchFindMyApp(
        arguments: ["--testing"],
        environment: ["TEST_MODE": "1"]
    )
}
```

#### Store and Retrieve Test Data
```swift
func testWithSharedData() throws {
    // Store test data
    TestContext.shared.setTestData(key: "deviceName", value: "iPhone 15")
    TestContext.shared.setTestData(key: "testUser", value: "test@example.com")
    
    // Retrieve test data in another test
    if let deviceName = TestContext.shared.getTestData(key: "deviceName") as? String {
        print("Testing with device: \(deviceName)")
    }
}
```

#### Screenshot Management
```swift
func testWithScreenshots() throws {
    let app = TestContext.shared.getFindMyApp()
    
    // Capture and save screenshot
    let screenshot = XCTAttachment(screenshot: app.screenshot())
    screenshot.name = "FindMy Main Screen"
    screenshot.lifetime = .keepAlways
    TestContext.shared.saveScreenshot(name: "main_screen", screenshot: screenshot)
}
```

#### Cleanup Between Tests
```swift
override func tearDownWithError() throws {
    // Terminate app and reset context
    TestContext.shared.terminateFindMyApp()
    TestContext.shared.reset()
}
```

## Configuration Options

Default configuration values:
- `defaultTimeout`: 10.0 seconds
- `launchWaitTime`: 5.0 seconds
- `findMyBundleId`: "com.apple.findmy"

## Test Structure

### FindMeAppCTLTestUITests.swift
Main UI test cases for FindMy app functionality.

### FindMeAppCTLTestUITestsLaunchTests.swift
Launch-specific tests with screenshot capture.

### TestContext.swift
Singleton class for managing test context and shared data.

### PageObjects/
Folder containing Page Object classes following the Page Object design pattern:
- **BasePage.swift**: Base class with common UI interaction methods
- **FindMyMainPage.swift**: Page object for FindMy main screen
- **README.md**: Detailed documentation on the Page Object pattern

## Best Practices

1. **Use TestContext for app management**: Always use `TestContext.shared.launchFindMyApp()` instead of creating new app instances
2. **Use Page Objects**: Interact with UI through page objects, not directly with XCUIElement
3. **Clean up after tests**: Call `TestContext.shared.reset()` in tearDown methods
4. **Store reusable data**: Use TestContext to share data between tests
5. **Centralize configuration**: Update test configuration through TestContext
6. **Manage screenshots**: Use TestContext to organize and retrieve screenshots
7. **Method chaining**: Use page object method chaining for readable test flows

## Future Test Areas

- Device/Item listing and navigation
- Map interactions and location features
- Search functionality
- Notifications and alerts
- Settings and preferences
- Tab navigation (Devices, Items, Me)
