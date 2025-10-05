# Notification Center Control Feature

## Overview

Added the ability to **open and close the notification center** programmatically in the `NotificationHelper` class. This allows tests to view notifications that are not immediately visible on screen.

## New Features

### 1. Manual Control Methods

```swift
// Open notification center
notificationHelper.openNotificationCenter()

// Close notification center
notificationHelper.closeNotificationCenter()
```

### 2. Automatic Opening with Wait Methods

All `waitForNotification` methods now support an optional `openCenter` parameter:

```swift
// Wait for notification and open center first
notificationHelper.waitForNotification(openCenter: true)

// Wait for specific text with center opened
notificationHelper.waitForNotification(
    withText: "Sound playing",
    openCenter: true
)

// Wait for pattern match with center opened
notificationHelper.waitForNotification(
    matchingPattern: ".*(found|located).*",
    openCenter: true
)

// Wait for app notification with center opened
notificationHelper.waitForNotification(
    fromApp: "FindMy",
    openCenter: true
)
```

## Use Cases

### Use Case 1: Check for Historical Notifications

```swift
// Open notification center to see all notifications
notificationHelper.openNotificationCenter()

// Check count
let count = notificationHelper.getNotificationCount()
print("Found \(count) notifications")

// Print all
notificationHelper.printAllNotifications()

// Close when done
notificationHelper.closeNotificationCenter()
```

### Use Case 2: Wait for Notification After Action

```swift
// Perform action that triggers notification
devicePage.playSound()

// Open notification center and wait
let notification = notificationHelper.waitForNotification(
    matchingPattern: ".*(sound|playing).*",
    timeout: 15.0,
    openCenter: true
)

if notification != nil {
    print("✅ Notification appeared")
}

// Clean up
notificationHelper.closeNotificationCenter()
```

### Use Case 3: Verify Notifications in Background

```swift
// App running in background, notifications accumulate
// Open center to check them
notificationHelper.openNotificationCenter()

// Verify specific notification exists
notificationHelper.verifyNotificationExists(withText: "Device found")

// Clear all
notificationHelper.clearAllNotifications()
```

## Implementation Details

### Opening Notification Center

The `openNotificationCenter()` method:
1. Swipes down from top of screen (0.5, 0.01) to (0.5, 0.3)
2. Waits 1 second for animation to complete
3. Notification center is now visible

### Closing Notification Center

The `closeNotificationCenter()` method:
1. Swipes up from center (0.5, 0.5) to top (0.5, 0.01)
2. Waits 0.5 seconds for animation to complete
3. Notification center is now hidden

### Default Behavior

By default, `openCenter` is `false` to maintain backward compatibility:
- Existing tests continue to work without changes
- Notifications must be visible on screen to be detected
- Opt-in to opening notification center when needed

## Updated Methods

All wait methods now include the `openCenter` parameter:

| Method | New Signature |
|--------|---------------|
| `waitForNotification` | `waitForNotification(timeout:openCenter:)` |
| `waitForNotification(withText:)` | `waitForNotification(withText:exactMatch:timeout:openCenter:)` |
| `waitForNotification(matchingPattern:)` | `waitForNotification(matchingPattern:timeout:openCenter:)` |
| `waitForNotification(fromApp:)` | `waitForNotification(fromApp:timeout:openCenter:)` |

## Example Test

```swift
@MainActor
func testWaitForNotificationWithOpenCenter() throws {
    let notificationHelper = NotificationHelper()
    
    // Open notification center and wait for notification
    print("🔔 Opening notification center...")
    
    let notification = notificationHelper.waitForNotification(
        withText: "FindMy",
        timeout: 10.0,
        openCenter: true  // ← New parameter
    )
    
    if let notification = notification {
        print("✅ Found: \(notification.label)")
    }
    
    // Close when done
    notificationHelper.closeNotificationCenter()
}
```

## Benefits

✅ **Access historical notifications** - View notifications that appeared earlier  
✅ **More reliable testing** - Don't miss notifications that aren't immediately visible  
✅ **Better debugging** - Manually inspect notification center during test development  
✅ **Backward compatible** - Existing tests work without changes  
✅ **Flexible** - Use automatic or manual control as needed  

## Documentation Updated

- ✅ `docs/NOTIFICATION_TESTING.md` - Full API reference
- ✅ `NOTIFICATION_TESTS_QUICKSTART.md` - Quick reference guide
- ✅ `NotificationTests.swift` - Example test added
- ✅ `NotificationHelper.swift` - Implementation complete

## Build Status

✅ **BUILD SUCCEEDED** - All changes compiled successfully

---

**Feature Added**: 2025-10-05  
**Status**: Ready for use
