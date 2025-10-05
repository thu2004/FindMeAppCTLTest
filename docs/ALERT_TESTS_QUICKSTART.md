# Alert Tests Quick Start Guide

Quick reference for testing iOS alerts and popups in FindMy app UI tests.

## Setup

```swift
let alertHelper = AlertHelper(app: app, timeout: 15.0)
```

## Common Operations

### Wait for Alert

```swift
// Wait for any alert
let alert = alertHelper.waitForAlert()

// Wait for specific alert
let alert = alertHelper.waitForAlert(withTitle: "Find My iPhone Alert")

// Wait with pattern
let alert = alertHelper.waitForAlert(matchingPattern: ".*Error.*")
```

### Handle Alert Buttons

```swift
// Tap OK
alertHelper.tapOK()

// Tap Cancel
alertHelper.tapCancel()

// Tap Allow (permissions)
alertHelper.tapAllow()

// Tap custom button
alertHelper.tapButton("Continue")

// Dismiss with first button
alertHelper.dismissAlert()
```

### Verify Alerts

```swift
// Assert alert exists
alertHelper.verifyAlertExists()

// Assert specific alert exists
alertHelper.verifyAlertExists(withTitle: "Error")

// Assert no alert exists
alertHelper.verifyNoAlertExists()
```

### Get Alert Info

```swift
// Get title
let title = alertHelper.getAlertTitle()

// Get buttons
let buttons = alertHelper.getAlertButtons()

// Get messages
let messages = alertHelper.getAlertMessages()

// Check if alert exists
let hasAlert = alertHelper.hasAlert()
```

### Debug

```swift
// Print all alerts
alertHelper.printAllAlerts()

// Print specific alert details
alertHelper.printAlertDetails(alert: alert)
```

## Example Test

```swift
@MainActor
func testPlaySoundAlert() throws {
    let alertHelper = AlertHelper(app: app)
    let mainPage = FindMyMainPage(app: app)
    
    // Navigate and play sound
    mainPage.navigateToDevicesTab()
    let devicePage = mainPage.tapFirstDevice()
    devicePage.playSound()
    
    // Wait for alert
    let alert = alertHelper.waitForAlert(timeout: 15.0)
    
    if let alert = alert {
        print("✅ Alert: \(alertHelper.getAlertTitle(from: alert))")
        
        // Get buttons
        let buttons = alertHelper.getAlertButtons(from: alert)
        print("   Buttons: \(buttons)")
        
        // Tap OK
        alertHelper.tapOK(in: alert)
    } else {
        XCTFail("Expected alert did not appear")
    }
}
```

## Pattern Examples

```swift
// Match error or warning
".*(Error|Warning).*"

// Match Find My alerts
"^Find My.*"

// Match permission alerts
".*(Allow|Permission|Access).*"

// Match device-specific alerts
".*'s (iPhone|iPad|Mac).*"
```

## Best Practices

1. **Wait for alerts**: Use `waitForAlert()` with appropriate timeout
2. **Handle immediately**: Don't let alerts accumulate
3. **Verify dismissal**: Check alert is gone after tapping button
4. **Clean up**: Dismiss any remaining alerts in tearDown
5. **Debug when failing**: Use `printAllAlerts()` to see what's available

## Common Alert Buttons

- **OK** - Acknowledge/confirm
- **Cancel** - Cancel action
- **Allow** - Grant permission
- **Don't Allow** - Deny permission
- **Continue** - Proceed with action
- **Close** - Close alert
- **Dismiss** - Dismiss alert

## Full Documentation

See [ALERT_TESTING.md](docs/ALERT_TESTING.md) for complete API reference and examples.
