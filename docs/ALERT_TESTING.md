# iOS Alert Testing Guide

This guide explains how to use the `AlertHelper` class to test iOS alerts and popups in UI tests.

## Overview

The `AlertHelper` class provides utilities to:
- Wait for alerts to appear (from springboard or app)
- Verify alert content
- Tap alert buttons (OK, Cancel, Allow, etc.)
- Get alert information (title, messages, buttons)
- Debug alerts with print utilities

## Quick Start

### 1. Initialize the Helper

```swift
let app = XCUIApplication()
let alertHelper = AlertHelper(app: app, timeout: 15.0)
```

### 2. Wait for an Alert

```swift
// Wait for any alert
let alert = alertHelper.waitForAlert()

// Wait for alert with specific title
let alert = alertHelper.waitForAlert(withTitle: "Find My iPhone Alert")

// Wait for alert matching pattern
let alert = alertHelper.waitForAlert(matchingPattern: ".*iPhone.*")
```

### 3. Interact with Alerts

```swift
// Tap OK button
alertHelper.tapOK()

// Tap Cancel button
alertHelper.tapCancel()

// Tap Allow button (permissions)
alertHelper.tapAllow()

// Tap custom button
alertHelper.tapButton("Continue")

// Dismiss with first button
alertHelper.dismissAlert()
```

### 4. Verify Alerts

```swift
// Verify alert exists
alertHelper.verifyAlertExists()

// Verify specific alert exists
alertHelper.verifyAlertExists(withTitle: "Error")

// Verify no alert exists
alertHelper.verifyNoAlertExists()
```

### 5. Get Alert Information

```swift
// Check if alert exists
let hasAlert = alertHelper.hasAlert()

// Get alert title
let title = alertHelper.getAlertTitle()

// Get all button labels
let buttons = alertHelper.getAlertButtons()

// Get alert messages
let messages = alertHelper.getAlertMessages()

// Print all alerts (debugging)
alertHelper.printAllAlerts()
```

## API Reference

### Initialization

```swift
init(app: XCUIApplication, timeout: TimeInterval = 10.0)
```

Creates a new alert helper for the specified app with default timeout.

### Properties

#### `springboardAlerts`
Returns all visible alerts from springboard (system alerts).

#### `appAlerts`
Returns all visible alerts from the app.

#### `firstAlert`
Returns the first visible alert (checks both springboard and app).

---

### Wait Methods

#### `waitForAlert(timeout:)`
Waits for any alert to appear (checks both springboard and app).

**Parameters:**
- `timeout`: Custom timeout (optional)

**Returns:** `XCUIElement?` - The alert element or nil

**Example:**
```swift
if let alert = alertHelper.waitForAlert(timeout: 10.0) {
    print("Alert found: \(alert.label)")
}
```

---

#### `waitForAlert(withTitle:exactMatch:timeout:)`
Waits for an alert with specific title.

**Parameters:**
- `title`: Alert title to search for
- `exactMatch`: Exact or contains match (default: false)
- `timeout`: Custom timeout (optional)

**Returns:** `XCUIElement?` - The alert element or nil

**Examples:**
```swift
// Contains match
let alert = alertHelper.waitForAlert(withTitle: "iPhone")

// Exact match
let alert = alertHelper.waitForAlert(withTitle: "Find My iPhone Alert", exactMatch: true)
```

---

#### `waitForAlert(matchingPattern:timeout:)`
Waits for an alert matching a regular expression pattern.

**Parameters:**
- `pattern`: Regular expression pattern
- `timeout`: Custom timeout (optional)

**Returns:** `XCUIElement?` - The alert element or nil

**Example:**
```swift
let alert = alertHelper.waitForAlert(matchingPattern: ".*(Error|Warning).*")
```

---

### Verification Methods

#### `verifyAlertExists(timeout:file:line:)`
Verifies that an alert exists. Fails the test if not found.

---

#### `verifyAlertExists(withTitle:exactMatch:timeout:file:line:)`
Verifies that an alert with specific title exists.

---

#### `verifyNoAlertExists(file:line:)`
Verifies that no alert exists.

---

### Interaction Methods

#### `tapButton(_:in:waitForDismissal:)`
Taps a button in the alert by label.

**Parameters:**
- `buttonLabel`: Button label to tap
- `alert`: Alert element (optional, uses first match if nil)
- `waitForDismissal`: Wait for alert to dismiss (default: true)

**Returns:** `Bool` - True if button was tapped

**Example:**
```swift
alertHelper.tapButton("Continue")
```

---

#### `tapOK(in:)`
Taps the OK button in the alert.

**Example:**
```swift
alertHelper.tapOK()
```

---

#### `tapCancel(in:)`
Taps the Cancel button in the alert.

---

#### `tapAllow(in:)`
Taps the Allow button (for permission alerts).

---

#### `tapDontAllow(in:)`
Taps the Don't Allow button (for permission alerts).

---

#### `dismissAlert(alert:)`
Dismisses the alert by tapping the first button.

---

### Information Methods

#### `getAlertTitle(from:)`
Gets the alert title/label.

**Returns:** `String` - Alert title

---

#### `getAlertButtons(from:)`
Gets all button labels from the alert.

**Returns:** `[String]` - Array of button labels

---

#### `getAlertMessages(from:)`
Gets all static text messages from the alert.

**Returns:** `[String]` - Array of message texts

---

#### `hasAlert()`
Checks if any alert exists.

**Returns:** `Bool` - True if alert exists

---

#### `getAlertCount()`
Gets the count of visible alerts.

**Returns:** `Int` - Number of alerts

---

### Debug Methods

#### `printAllAlerts()`
Prints all visible alerts with details (for debugging).

#### `printAlertDetails(alert:)`
Prints details of a specific alert.

---

## Common Use Cases

### Test Case 1: Handle Alert After Action

```swift
@MainActor
func testPlaySoundAndHandleAlert() throws {
    let alertHelper = AlertHelper(app: app)
    
    // Perform action that triggers alert
    devicePage.playSound()
    
    // Wait for alert
    let alert = alertHelper.waitForAlert(timeout: 15.0)
    
    if let alert = alert {
        print("Alert: \(alertHelper.getAlertTitle(from: alert))")
        alertHelper.tapOK(in: alert)
    } else {
        XCTFail("Expected alert did not appear")
    }
}
```

### Test Case 2: Handle Permission Alert

```swift
@MainActor
func testLocationPermission() throws {
    let alertHelper = AlertHelper(app: app)
    
    // Trigger location permission
    // ...
    
    // Wait for permission alert
    let alert = alertHelper.waitForAlert(withTitle: "Location")
    
    if let alert = alert {
        alertHelper.tapAllow(in: alert)
        print("✅ Location permission granted")
    }
}
```

### Test Case 3: Verify No Errors

```swift
@MainActor
func testNoErrorAlerts() throws {
    let alertHelper = AlertHelper(app: app)
    
    // Perform actions
    // ...
    
    // Verify no error alerts
    alertHelper.verifyNoAlertExists()
}
```

### Test Case 4: Get Alert Information

```swift
@MainActor
func testAlertContent() throws {
    let alertHelper = AlertHelper(app: app)
    
    let alert = alertHelper.waitForAlert()
    
    if let alert = alert {
        let title = alertHelper.getAlertTitle(from: alert)
        let messages = alertHelper.getAlertMessages(from: alert)
        let buttons = alertHelper.getAlertButtons(from: alert)
        
        print("Title: \(title)")
        print("Messages: \(messages)")
        print("Buttons: \(buttons)")
    }
}
```

### Test Case 5: Auto-Handle Alerts with Interruption Monitor

```swift
@MainActor
func testWithInterruptionHandler() throws {
    let alertHelper = AlertHelper(app: app)
    
    // Add interruption monitor
    addUIInterruptionMonitor(withDescription: "Alert Handler") { alert in
        print("Alert interrupted: \(alert.label)")
        return alertHelper.tapOK(in: alert)
    }
    
    // Perform actions that may trigger alerts
    // ...
    
    // Tap to trigger monitor
    app.tap()
}
```

## Alert Types

### System Alerts (Springboard)
- Permission requests (Location, Notifications, etc.)
- System dialogs
- App Store alerts
- Find My iPhone alerts

### App Alerts
- In-app error messages
- Confirmation dialogs
- Custom alerts

## Best Practices

### 1. Check Both Sources

The helper automatically checks both springboard and app alerts:

```swift
// Checks both automatically
let alert = alertHelper.waitForAlert()
```

### 2. Use Specific Titles When Possible

```swift
// More reliable than waiting for any alert
let alert = alertHelper.waitForAlert(withTitle: "Find My iPhone Alert")
```

### 3. Handle Alerts Immediately

```swift
// Don't let alerts accumulate
if let alert = alertHelper.waitForAlert(timeout: 5.0) {
    alertHelper.tapOK(in: alert)
}
```

### 4. Verify No Unexpected Alerts

```swift
// At end of test
alertHelper.verifyNoAlertExists()
```

### 5. Debug with Print Methods

```swift
// When alert behavior is unexpected
alertHelper.printAllAlerts()
```

## Pattern Matching Examples

### Basic Patterns

```swift
// Match "Error" or "Warning"
".*(Error|Warning).*"

// Match any alert starting with "Find My"
"^Find My.*"

// Match permission alerts
".*(Allow|Permission).*"
```

### Advanced Patterns

```swift
// Match error codes
"Error \\d+: .*"

// Match device names
".*'s (iPhone|iPad|Mac).*"

// Match time-based alerts
".*(minute|hour|day)s? ago.*"
```

## Troubleshooting

### Alert Not Found

1. **Check if alert actually appears**: Observe device during test
2. **Print all alerts**: Use `printAllAlerts()` to see what's available
3. **Increase timeout**: Some alerts may take longer to appear
4. **Check both sources**: Alert may be in app or springboard

### Button Not Found

1. **Print alert details**: Use `printAlertDetails()` to see available buttons
2. **Check button label**: Button text may be different than expected
3. **Try pattern matching**: Use flexible matching for button labels

### Alert Won't Dismiss

1. **Verify button tap**: Check if button exists before tapping
2. **Wait longer**: Some alerts need time to dismiss
3. **Check for nested alerts**: Another alert may appear after dismissing

## Integration Example

Add alert helper to your test class:

```swift
final class DeviceTests: XCTestCase {
    private var app: XCUIApplication!
    private var mainPage: FindMyMainPage!
    private var alertHelper: AlertHelper!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        TestContext.shared.launchFindMyApp()
        app = TestContext.shared.getFindMyApp()
        mainPage = FindMyMainPage(app: app)
        
        // Initialize alert helper
        alertHelper = AlertHelper(app: app, timeout: 15.0)
    }
    
    override func tearDownWithError() throws {
        // Dismiss any remaining alerts
        if alertHelper.hasAlert() {
            alertHelper.dismissAlert()
        }
        
        TestContext.shared.terminateFindMyApp()
    }
}
```

## See Also

- [Notification Testing Documentation](NOTIFICATION_TESTING.md)
- [Device Tests Documentation](DEVICE_TESTS.md)
- [Apple XCTest Documentation](https://developer.apple.com/documentation/xctest)
