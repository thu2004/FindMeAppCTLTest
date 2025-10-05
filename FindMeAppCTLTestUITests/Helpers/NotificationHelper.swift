//
//  NotificationHelper.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Helper class for testing iOS notifications in UI tests
/// Provides utilities to wait for, verify, and clear notifications
class NotificationHelper {
    
    // MARK: - Properties
    
    /// Springboard application (iOS home screen)
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    /// Default timeout for notification operations
    private let defaultTimeout: TimeInterval
    
    // MARK: - Initialization
    
    init(timeout: TimeInterval = 10.0) {
        self.defaultTimeout = timeout
    }
    
    // MARK: - Notification Access
    
    /// Get all visible notification cells
    var notificationCells: XCUIElementQuery {
        return springboard.otherElements.matching(NSPredicate(format: "identifier CONTAINS 'NotificationCell'"))
    }
    
    /// Get all visible notifications (short look view)
    var notifications: XCUIElementQuery {
        return springboard.otherElements.matching(identifier: "NotificationShortLookView")
    }
    
    /// Get notification center
    var notificationCenter: XCUIElement {
        return springboard.otherElements["Notification Center"]
    }
    
    /// Get cover sheet (notification center container)
    var coverSheet: XCUIElement {
        return springboard.otherElements["SBDashBoardView"]
    }
    
    // MARK: - Notification Center Control
    
    /// Open notification center by swiping down from top
    @discardableResult
    func openNotificationCenter() -> Bool {
        // Method 1: Swipe down from status bar
        let statusBar = springboard.statusBars.firstMatch
        if statusBar.exists {
            let start = statusBar.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            let end = springboard.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
            start.press(forDuration: 0.1, thenDragTo: end)
            Thread.sleep(forTimeInterval: 1.5)
            return true
        }
        
        // Method 2: Fallback - swipe from top edge
        let topCoordinate = springboard.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.0))
        let bottomCoordinate = springboard.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
        topCoordinate.press(forDuration: 0.1, thenDragTo: bottomCoordinate)
        Thread.sleep(forTimeInterval: 1.5)
        return true
    }
    
    /// Close notification center by swiping up
    @discardableResult
    func closeNotificationCenter() -> Bool {
        let bottomCoordinate = springboard.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
        let topCoordinate = springboard.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.0))
        bottomCoordinate.press(forDuration: 0.1, thenDragTo: topCoordinate)
        Thread.sleep(forTimeInterval: 0.8)
        return true
    }
    
    // MARK: - Wait for Notifications
    
    /// Wait for any notification to appear
    /// - Parameters:
    ///   - timeout: Custom timeout (uses default if nil)
    ///   - openCenter: If true, opens notification center first (default: false)
    /// - Returns: True if notification appeared, false otherwise
    @discardableResult
    func waitForNotification(timeout: TimeInterval? = nil, openCenter: Bool = false) -> Bool {
        if openCenter {
            openNotificationCenter()
        }
        
        let timeoutValue = timeout ?? defaultTimeout
        let notification = notifications.firstMatch
        return notification.waitForExistence(timeout: timeoutValue)
    }
    
    /// Wait for a notification with specific text
    /// - Parameters:
    ///   - text: Text to search for in notification
    ///   - exactMatch: If true, requires exact match; if false, uses contains
    ///   - timeout: Custom timeout (uses default if nil)
    ///   - openCenter: If true, opens notification center first (default: false)
    /// - Returns: The matching notification element if found, nil otherwise
    @discardableResult
    func waitForNotification(withText text: String, exactMatch: Bool = false, timeout: TimeInterval? = nil, openCenter: Bool = false) -> XCUIElement? {
        if openCenter {
            openNotificationCenter()
        }
        
        let timeoutValue = timeout ?? defaultTimeout
        let predicate: NSPredicate
        
        if exactMatch {
            predicate = NSPredicate(format: "label == %@", text)
        } else {
            predicate = NSPredicate(format: "label CONTAINS[c] %@", text)
        }
        
        let notification = springboard.otherElements.containing(predicate).firstMatch
        
        if notification.waitForExistence(timeout: timeoutValue) {
            return notification
        }
        return nil
    }
    
    /// Wait for a notification matching a pattern
    /// - Parameters:
    ///   - pattern: Regular expression pattern to match
    ///   - timeout: Custom timeout (uses default if nil)
    ///   - openCenter: If true, opens notification center first (default: false)
    /// - Returns: The matching notification element if found, nil otherwise
    @discardableResult
    func waitForNotification(matchingPattern pattern: String, timeout: TimeInterval? = nil, openCenter: Bool = false) -> XCUIElement? {
        if openCenter {
            openNotificationCenter()
        }
        
        let timeoutValue = timeout ?? defaultTimeout
        let predicate = NSPredicate(format: "label MATCHES %@", pattern)
        let notification = springboard.otherElements.containing(predicate).firstMatch
        
        if notification.waitForExistence(timeout: timeoutValue) {
            return notification
        }
        return nil
    }
    
    /// Wait for a notification from a specific app
    /// - Parameters:
    ///   - appName: Name of the app
    ///   - timeout: Custom timeout (uses default if nil)
    ///   - openCenter: If true, opens notification center first (default: false)
    /// - Returns: The matching notification element if found, nil otherwise
    @discardableResult
    func waitForNotification(fromApp appName: String, timeout: TimeInterval? = nil, openCenter: Bool = false) -> XCUIElement? {
        if openCenter {
            openNotificationCenter()
        }
        
        let timeoutValue = timeout ?? defaultTimeout
        
        // Look for notification with app name in the header
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", appName)
        let notification = springboard.staticTexts.containing(predicate).firstMatch
        
        if notification.waitForExistence(timeout: timeoutValue) {
            return notification
        }
        return nil
    }
    
    // MARK: - Notification Verification
    
    /// Verify that a notification exists with specific text
    /// - Parameters:
    ///   - text: Text to search for
    ///   - exactMatch: If true, requires exact match; if false, uses contains
    ///   - timeout: Custom timeout (uses default if nil)
    ///   - file: Source file (for assertion)
    ///   - line: Line number (for assertion)
    func verifyNotificationExists(withText text: String, exactMatch: Bool = false, timeout: TimeInterval? = nil, file: StaticString = #file, line: UInt = #line) {
        let notification = waitForNotification(withText: text, exactMatch: exactMatch, timeout: timeout)
        XCTAssertTrue(notification != nil, "Notification with text '\(text)' not found", file: file, line: line)
    }
    
    /// Verify that a notification exists matching a pattern
    /// - Parameters:
    ///   - pattern: Regular expression pattern
    ///   - timeout: Custom timeout (uses default if nil)
    ///   - file: Source file (for assertion)
    ///   - line: Line number (for assertion)
    func verifyNotificationExists(matchingPattern pattern: String, timeout: TimeInterval? = nil, file: StaticString = #file, line: UInt = #line) {
        let notification = waitForNotification(matchingPattern: pattern, timeout: timeout)
        XCTAssertTrue(notification != nil, "Notification matching pattern '\(pattern)' not found", file: file, line: line)
    }
    
    /// Verify that no notification exists with specific text
    /// - Parameters:
    ///   - text: Text to search for
    ///   - file: Source file (for assertion)
    ///   - line: Line number (for assertion)
    func verifyNotificationDoesNotExist(withText text: String, file: StaticString = #file, line: UInt = #line) {
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", text)
        let notification = springboard.otherElements.containing(predicate).firstMatch
        XCTAssertFalse(notification.exists, "Notification with text '\(text)' should not exist", file: file, line: line)
    }
    
    // MARK: - Notification Interaction
    
    /// Tap on a notification with specific text
    /// - Parameters:
    ///   - text: Text to search for
    ///   - exactMatch: If true, requires exact match; if false, uses contains
    ///   - timeout: Custom timeout (uses default if nil)
    /// - Returns: True if notification was tapped, false otherwise
    @discardableResult
    func tapNotification(withText text: String, exactMatch: Bool = false, timeout: TimeInterval? = nil) -> Bool {
        guard let notification = waitForNotification(withText: text, exactMatch: exactMatch, timeout: timeout) else {
            return false
        }
        notification.tap()
        return true
    }
    
    /// Tap on the first visible notification
    /// - Parameter timeout: Custom timeout (uses default if nil)
    /// - Returns: True if notification was tapped, false otherwise
    @discardableResult
    func tapFirstNotification(timeout: TimeInterval? = nil) -> Bool {
        let timeoutValue = timeout ?? defaultTimeout
        let notification = notifications.firstMatch
        
        if notification.waitForExistence(timeout: timeoutValue) {
            notification.tap()
            return true
        }
        return false
    }
    
    /// Swipe to dismiss a notification with specific text
    /// - Parameters:
    ///   - text: Text to search for
    ///   - direction: Swipe direction (default: up)
    ///   - timeout: Custom timeout (uses default if nil)
    /// - Returns: True if notification was dismissed, false otherwise
    @discardableResult
    func dismissNotification(withText text: String, direction: SwipeDirection = .up, timeout: TimeInterval? = nil) -> Bool {
        guard let notification = waitForNotification(withText: text, timeout: timeout) else {
            return false
        }
        
        switch direction {
        case .up:
            notification.swipeUp()
        case .down:
            notification.swipeDown()
        case .left:
            notification.swipeLeft()
        case .right:
            notification.swipeRight()
        }
        return true
    }
    
    // MARK: - Clear Notifications
    
    /// Clear all notifications by opening notification center and clearing
    func clearAllNotifications() {
        // Open notification center
        openNotificationCenter()
        
        // Look for "Clear" or "Clear All" button
        let clearButton = springboard.buttons["Clear"]
        if clearButton.exists {
            clearButton.tap()
            Thread.sleep(forTimeInterval: 0.5)
        }
        
        // Alternative: Look for X buttons on individual notifications
        let closeButtons = springboard.buttons["Clear All Notifications"]
        if closeButtons.exists {
            closeButtons.tap()
            Thread.sleep(forTimeInterval: 0.5)
        }
        
        // Close notification center
        closeNotificationCenter()
    }
    
    /// Clear a specific notification by swiping it away
    /// - Parameter text: Text to search for in the notification
    /// - Returns: True if notification was cleared, false otherwise
    @discardableResult
    func clearNotification(withText text: String) -> Bool {
        return dismissNotification(withText: text, direction: .up)
    }
    
    // MARK: - Notification Count
    
    /// Get the count of visible notifications
    /// - Returns: Number of visible notifications
    func getNotificationCount() -> Int {
        return notifications.count
    }
    
    /// Check if any notifications are visible
    /// - Returns: True if at least one notification exists
    func hasNotifications() -> Bool {
        return notifications.firstMatch.exists
    }
    
    // MARK: - Notification Content
    
    /// Get all notification labels (text content)
    /// - Returns: Array of notification text labels
    func getAllNotificationTexts() -> [String] {
        var texts: [String] = []
        let notificationElements = notifications.allElementsBoundByIndex
        
        for notification in notificationElements {
            if notification.exists {
                texts.append(notification.label)
            }
        }
        return texts
    }
    
    /// Print all visible notifications (for debugging)
    func printAllNotifications() {
        let notificationTexts = getAllNotificationTexts()
        print("\n📱 VISIBLE NOTIFICATIONS (\(notificationTexts.count)):")
        print(String(repeating: "-", count: 60))
        for (index, text) in notificationTexts.enumerated() {
            print("[\(index)] \(text)")
        }
        print(String(repeating: "-", count: 60) + "\n")
    }
    
    // MARK: - Helper Methods
    
    /// Wait for a specified duration
    /// - Parameter duration: Time to wait in seconds
    func wait(_ duration: TimeInterval) {
        Thread.sleep(forTimeInterval: duration)
    }
}
