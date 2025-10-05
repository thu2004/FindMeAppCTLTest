# iOS Notification Testing Guide

This guide explains how to use the `NotificationHelper` class to test iOS notifications in UI tests.

## Overview

The `NotificationHelper` class provides utilities to:
- Wait for notifications to appear
- Verify notification content
- Tap on notifications
- Dismiss/clear notifications
- Get notification counts and content

## Quick Start

### 1. Initialize the Helper

```swift
let notificationHelper = NotificationHelper(timeout: 15.0)
```

### 2. Wait for a Notification

```swift
// Wait for any notification
notificationHelper.waitForNotification()

// Wait for notification with specific text
let notification = notificationHelper.waitForNotification(withText: "FindMy")

// Wait for notification matching a pattern
let notification = notificationHelper.waitForNotification(matchingPattern: ".*(found|located).*")

// Wait for notification from specific app
let notification = notificationHelper.waitForNotification(fromApp: "FindMy")

// Open notification center first, then wait
let notification = notificationHelper.waitForNotification(withText: "FindMy", openCenter: true)
```

### 2a. Control Notification Center

```swift
// Manually open notification center
notificationHelper.openNotificationCenter()

// Manually close notification center
notificationHelper.closeNotificationCenter()
```

### 3. Verify Notifications

```swift
// Verify notification exists (fails test if not found)
notificationHelper.verifyNotificationExists(withText: "Sound playing")

// Verify notification does NOT exist
notificationHelper.verifyNotificationDoesNotExist(withText: "error")

// Verify with pattern matching
notificationHelper.verifyNotificationExists(matchingPattern: ".*(success|complete).*")
```

### 4. Interact with Notifications

```swift
// Tap on a notification
notificationHelper.tapNotification(withText: "FindMy")

// Tap first visible notification
notificationHelper.tapFirstNotification()

// Dismiss notification by swiping
notificationHelper.dismissNotification(withText: "FindMy", direction: .up)
```

### 5. Clear Notifications

```swift
// Clear all notifications
notificationHelper.clearAllNotifications()

// Clear specific notification
notificationHelper.clearNotification(withText: "FindMy")
```

### 6. Get Notification Information

```swift
// Get count of visible notifications
let count = notificationHelper.getNotificationCount()

// Check if any notifications exist
let hasNotifications = notificationHelper.hasNotifications()

// Get all notification texts
let texts = notificationHelper.getAllNotificationTexts()

// Print all notifications (for debugging)
notificationHelper.printAllNotifications()
```

## API Reference

### Initialization

```swift
init(timeout: TimeInterval = 10.0)
```

Creates a new notification helper with the specified default timeout.

### Notification Center Control

#### `openNotificationCenter()`
Opens the notification center by swiping down from the top of the screen.

**Usage:**
```swift
notificationHelper.openNotificationCenter()
```

---

#### `closeNotificationCenter()`
Closes the notification center by swiping up.

**Usage:**
```swift
notificationHelper.closeNotificationCenter()
```

---

### Wait Methods

#### `waitForNotification(timeout:openCenter:)`
Waits for any notification to appear.

**Parameters:**
- `timeout`: Custom timeout (optional, uses default if nil)
- `openCenter`: If true, opens notification center first (default: false)

**Returns:** `Bool` - True if notification appeared

---

#### `waitForNotification(withText:exactMatch:timeout:openCenter:)`
Waits for a notification containing specific text.

**Parameters:**
- `text`: Text to search for
- `exactMatch`: If true, requires exact match; if false, uses contains (default: false)
- `timeout`: Custom timeout (optional)
- `openCenter`: If true, opens notification center first (default: false)

**Returns:** `XCUIElement?` - The matching notification or nil

**Examples:**
```swift
// Contains match (case-insensitive)
let notification = notificationHelper.waitForNotification(withText: "sound")

// Exact match
let notification = notificationHelper.waitForNotification(withText: "Sound is playing", exactMatch: true)

// Open notification center first
let notification = notificationHelper.waitForNotification(withText: "sound", openCenter: true)
```

---

#### `waitForNotification(matchingPattern:timeout:openCenter:)`
Waits for a notification matching a regular expression pattern.

**Parameters:**
- `pattern`: Regular expression pattern
- `timeout`: Custom timeout (optional)
- `openCenter`: If true, opens notification center first (default: false)

**Returns:** `XCUIElement?` - The matching notification or nil

**Examples:**
```swift
// Match "found" or "located"
let notification = notificationHelper.waitForNotification(matchingPattern: ".*(found|located).*")

// Match any number
let notification = notificationHelper.waitForNotification(matchingPattern: ".*\\d+.*")

// Match specific format
let notification = notificationHelper.waitForNotification(matchingPattern: "Device .* is now online")
```

---

#### `waitForNotification(fromApp:timeout:)`
Waits for a notification from a specific app.

**Parameters:**
- `appName`: Name of the app
- `timeout`: Custom timeout (optional)

**Returns:** `XCUIElement?` - The matching notification or nil

---

### Verification Methods

#### `verifyNotificationExists(withText:exactMatch:timeout:file:line:)`
Verifies that a notification exists. Fails the test if not found.

**Parameters:**
- `text`: Text to search for
- `exactMatch`: Exact or contains match (default: false)
- `timeout`: Custom timeout (optional)
- `file`: Source file (automatic)
- `line`: Line number (automatic)

---

#### `verifyNotificationExists(matchingPattern:timeout:file:line:)`
Verifies that a notification matching a pattern exists.

**Parameters:**
- `pattern`: Regular expression pattern
- `timeout`: Custom timeout (optional)
- `file`: Source file (automatic)
- `line`: Line number (automatic)

---

#### `verifyNotificationDoesNotExist(withText:file:line:)`
Verifies that no notification with the specified text exists.

**Parameters:**
- `text`: Text to search for
- `file`: Source file (automatic)
- `line`: Line number (automatic)

---

### Interaction Methods

#### `tapNotification(withText:exactMatch:timeout:)`
Taps on a notification with specific text.

**Parameters:**
- `text`: Text to search for
- `exactMatch`: Exact or contains match (default: false)
- `timeout`: Custom timeout (optional)

**Returns:** `Bool` - True if notification was tapped

---

#### `tapFirstNotification(timeout:)`
Taps on the first visible notification.

**Parameters:**
- `timeout`: Custom timeout (optional)

**Returns:** `Bool` - True if notification was tapped

---

#### `dismissNotification(withText:direction:timeout:)`
Dismisses a notification by swiping.

**Parameters:**
- `text`: Text to search for
- `direction`: Swipe direction (default: .up)
- `timeout`: Custom timeout (optional)

**Returns:** `Bool` - True if notification was dismissed

**Available directions:**
- `.up` - Swipe up (most common)
- `.down` - Swipe down
- `.left` - Swipe left
- `.right` - Swipe right

---

### Clear Methods

#### `clearAllNotifications()`
Clears all visible notifications by opening notification center and clearing.

---

#### `clearNotification(withText:)`
Clears a specific notification by swiping it away.

**Parameters:**
- `text`: Text to search for

**Returns:** `Bool` - True if notification was cleared

---

### Information Methods

#### `getNotificationCount()`
Gets the count of visible notifications.

**Returns:** `Int` - Number of visible notifications

---

#### `hasNotifications()`
Checks if any notifications are visible.

**Returns:** `Bool` - True if at least one notification exists

---

#### `getAllNotificationTexts()`
Gets all notification text labels.

**Returns:** `[String]` - Array of notification text content

---

#### `printAllNotifications()`
Prints all visible notifications to console (for debugging).

---

## Common Use Cases

### Test Case 1: Play Sound and Wait for Notification

```swift
@MainActor
func testPlaySoundNotification() throws {
    let mainPage = FindMyMainPage(app: app)
    let notificationHelper = NotificationHelper()
    
    // Navigate to device
    mainPage.navigateToDevicesTab()
    let devicePage = mainPage.tapFirstDevice()
    
    // Clear existing notifications
    notificationHelper.clearAllNotifications()
    
    // Play sound
    devicePage.playSound()
    
    // Wait for notification
    notificationHelper.verifyNotificationExists(
        matchingPattern: ".*(sound|playing).*",
        timeout: 15.0
    )
}
```

### Test Case 2: Verify No Error Notifications

```swift
@MainActor
func testNoErrorNotifications() throws {
    let notificationHelper = NotificationHelper()
    
    // Perform actions...
    
    // Verify no errors
    notificationHelper.verifyNotificationDoesNotExist(withText: "error")
    notificationHelper.verifyNotificationDoesNotExist(withText: "failed")
}
```

### Test Case 3: Handle Multiple Notifications

```swift
@MainActor
func testMultipleNotifications() throws {
    let notificationHelper = NotificationHelper()
    
    // Trigger multiple notifications...
    
    // Check count
    let count = notificationHelper.getNotificationCount()
    XCTAssertEqual(count, 3, "Should have 3 notifications")
    
    // Print for debugging
    notificationHelper.printAllNotifications()
    
    // Clear specific one
    notificationHelper.clearNotification(withText: "First notification")
    
    // Verify count decreased
    XCTAssertEqual(notificationHelper.getNotificationCount(), 2)
}
```

### Test Case 4: Tap Notification to Open App

```swift
@MainActor
func testTapNotificationOpensApp() throws {
    let notificationHelper = NotificationHelper()
    
    // Wait for notification
    let notification = notificationHelper.waitForNotification(
        withText: "Device found",
        timeout: 10.0
    )
    
    // Tap to open app
    if let notification = notification {
        notificationHelper.tapNotification(withText: "Device found")
        
        // Verify app opened to correct screen
        let app = XCUIApplication()
        XCTAssertTrue(app.staticTexts["Device Details"].exists)
    }
}
```

## Pattern Matching Examples

### Basic Patterns

```swift
// Match any text containing "found"
".*(found).*"

// Match "found" or "located"
".*(found|located).*"

// Match text starting with "Device"
"^Device.*"

// Match text ending with "online"
".*online$"
```

### Advanced Patterns

```swift
// Match device name with status
"Device .* is (online|offline)"

// Match time format (e.g., "Last seen 5 minutes ago")
"Last seen \\d+ (minute|hour|day)s? ago"

// Match percentage
"Battery: \\d+%"

// Match coordinates
"Location: \\d+\\.\\d+, \\d+\\.\\d+"
```

## Best Practices

### 1. Clear Notifications Before Tests

```swift
override func setUpWithError() throws {
    notificationHelper = NotificationHelper()
    notificationHelper.clearAllNotifications()
}
```

### 2. Use Appropriate Timeouts

```swift
// Short timeout for expected notifications
notificationHelper.waitForNotification(withText: "Success", timeout: 5.0)

// Longer timeout for delayed notifications
notificationHelper.waitForNotification(withText: "Device found", timeout: 30.0)
```

### 3. Clean Up After Tests

```swift
override func tearDownWithError() throws {
    notificationHelper.clearAllNotifications()
}
```

### 4. Use Pattern Matching for Flexibility

```swift
// Instead of exact text (which may change)
notificationHelper.waitForNotification(withText: "Sound is playing on Chi's Laptop")

// Use pattern matching
notificationHelper.waitForNotification(matchingPattern: ".*playing.*")
```

### 5. Debug with Print Methods

```swift
// When notification isn't found, print all to see what's available
if !notificationHelper.waitForNotification(withText: "Expected") {
    print("Expected notification not found. Available notifications:")
    notificationHelper.printAllNotifications()
}
```

## Troubleshooting

### Notification Not Found

1. **Check if notification actually appears**: Run test and observe device
2. **Print all notifications**: Use `printAllNotifications()` to see what's available
3. **Increase timeout**: Some notifications may take longer to appear
4. **Check text matching**: Use pattern matching instead of exact text

### Can't Clear Notifications

1. **Verify notification center access**: Ensure UI tests can access springboard
2. **Try alternative methods**: Use `dismissNotification()` instead of `clearAllNotifications()`
3. **Add delays**: Some notifications need time to appear before clearing

### Springboard Access Issues

If you get errors accessing springboard:
1. Ensure test target has proper entitlements
2. Check that UI testing is enabled
3. Verify device/simulator permissions

## Integration with Existing Tests

Add notification helper to your test class:

```swift
final class DeviceTests: XCTestCase {
    private var app: XCUIApplication!
    private var mainPage: FindMyMainPage!
    private var notificationHelper: NotificationHelper!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        TestContext.shared.launchFindMyApp()
        app = TestContext.shared.getFindMyApp()
        mainPage = FindMyMainPage(app: app)
        
        // Initialize notification helper
        notificationHelper = NotificationHelper(timeout: 15.0)
        notificationHelper.clearAllNotifications()
    }
    
    override func tearDownWithError() throws {
        notificationHelper.clearAllNotifications()
        TestContext.shared.terminateFindMyApp()
    }
}
```

## Notes

- Notification testing requires access to Springboard (iOS home screen)
- Some notifications may not appear in UI tests depending on system settings
- Notification appearance timing can vary based on device performance
- Always clean up notifications to avoid test interference

## See Also

- [Device Tests Documentation](DEVICE_TESTS.md)
- [Page Object Pattern](README.md)
- [Apple XCTest Documentation](https://developer.apple.com/documentation/xctest)
