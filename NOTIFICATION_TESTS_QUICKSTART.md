# Notification Tests Quick Start Guide

Quick reference for testing iOS notifications in FindMy app UI tests.

## Setup

```swift
let notificationHelper = NotificationHelper(timeout: 15.0)
```

## Common Operations

### Open/Close Notification Center

```swift
// Open notification center
notificationHelper.openNotificationCenter()

// Close notification center
notificationHelper.closeNotificationCenter()
```

### Wait for Notification

```swift
// Wait for any notification
notificationHelper.waitForNotification()

// Wait for specific text
notificationHelper.waitForNotification(withText: "Sound playing")

// Wait with pattern matching
notificationHelper.waitForNotification(matchingPattern: ".*(found|located).*")

// Open notification center first, then wait
notificationHelper.waitForNotification(withText: "Sound playing", openCenter: true)
```

### Verify Notification

```swift
// Assert notification exists
notificationHelper.verifyNotificationExists(withText: "Success")

// Assert notification does NOT exist
notificationHelper.verifyNotificationDoesNotExist(withText: "error")
```

### Clear Notifications

```swift
// Clear all
notificationHelper.clearAllNotifications()

// Clear specific
notificationHelper.clearNotification(withText: "FindMy")
```

### Debug

```swift
// Print all visible notifications
notificationHelper.printAllNotifications()

// Get count
let count = notificationHelper.getNotificationCount()
```

## Example Test

```swift
@MainActor
func testPlaySoundNotification() throws {
    let notificationHelper = NotificationHelper()
    let mainPage = FindMyMainPage(app: app)
    
    // Clear existing notifications
    notificationHelper.clearAllNotifications()
    
    // Navigate and play sound
    mainPage.navigateToDevicesTab()
    let devicePage = mainPage.tapFirstDevice()
    devicePage.playSound()
    
    // Wait for notification
    notificationHelper.verifyNotificationExists(
        matchingPattern: ".*(sound|playing).*",
        timeout: 15.0
    )
    
    // Clean up
    notificationHelper.clearAllNotifications()
}
```

## Pattern Examples

```swift
// Match "found" or "located"
".*(found|located).*"

// Match any number
".*\\d+.*"

// Match device status
"Device .* is (online|offline)"

// Match time format
"Last seen \\d+ (minute|hour)s? ago"
```

## Best Practices

1. **Clear before test**: `notificationHelper.clearAllNotifications()`
2. **Use patterns**: More flexible than exact text matching
3. **Appropriate timeouts**: 5-15 seconds depending on notification type
4. **Debug when failing**: Use `printAllNotifications()` to see what's available
5. **Clean up after**: Clear notifications in `tearDownWithError()`

## Full Documentation

See [NOTIFICATION_TESTING.md](docs/NOTIFICATION_TESTING.md) for complete API reference and examples.
