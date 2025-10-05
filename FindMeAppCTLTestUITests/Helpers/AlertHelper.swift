//
//  AlertHelper.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Helper class for handling iOS alerts and popups in UI tests
/// Provides utilities to wait for, verify, and interact with alerts
class AlertHelper {
    
    // MARK: - Properties
    
    /// Springboard application (for system alerts)
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    /// App instance (for app-specific alerts)
    private let app: XCUIApplication
    
    /// Default timeout for alert operations
    private let defaultTimeout: TimeInterval
    
    // MARK: - Initialization
    
    init(app: XCUIApplication, timeout: TimeInterval = 10.0) {
        self.app = app
        self.defaultTimeout = timeout
    }
    
    // MARK: - Alert Access
    
    /// Get all visible alerts from springboard
    var springboardAlerts: XCUIElementQuery {
        return springboard.alerts
    }
    
    /// Get all visible alerts from app
    var appAlerts: XCUIElementQuery {
        return app.alerts
    }
    
    /// Get first alert (checks both springboard and app)
    var firstAlert: XCUIElement? {
        let springboardAlert = springboard.alerts.firstMatch
        if springboardAlert.exists {
            return springboardAlert
        }
        
        let appAlert = app.alerts.firstMatch
        if appAlert.exists {
            return appAlert
        }
        
        return nil
    }
    
    // MARK: - Wait for Alerts
    
    /// Wait for any alert to appear
    /// - Parameter timeout: Custom timeout (uses default if nil)
    /// - Returns: Alert element if found, nil otherwise
    @discardableResult
    func waitForAlert(timeout: TimeInterval? = nil) -> XCUIElement? {
        let timeoutValue = timeout ?? defaultTimeout
        
        // Check springboard alerts first
        let springboardAlert = springboard.alerts.firstMatch
        if springboardAlert.waitForExistence(timeout: timeoutValue) {
            return springboardAlert
        }
        
        // Check app alerts
        let appAlert = app.alerts.firstMatch
        if appAlert.waitForExistence(timeout: timeoutValue) {
            return appAlert
        }
        
        return nil
    }
    
    /// Wait for alert with specific title
    /// - Parameters:
    ///   - title: Alert title to search for
    ///   - exactMatch: If true, requires exact match; if false, uses contains
    ///   - timeout: Custom timeout (uses default if nil)
    /// - Returns: Alert element if found, nil otherwise
    @discardableResult
    func waitForAlert(withTitle title: String, exactMatch: Bool = false, timeout: TimeInterval? = nil) -> XCUIElement? {
        let timeoutValue = timeout ?? defaultTimeout
        
        // Check springboard alerts
        let springboardAlert: XCUIElement
        if exactMatch {
            springboardAlert = springboard.alerts[title]
        } else {
            let predicate = NSPredicate(format: "label CONTAINS[c] %@", title)
            springboardAlert = springboard.alerts.containing(predicate).firstMatch
        }
        
        if springboardAlert.waitForExistence(timeout: timeoutValue) {
            return springboardAlert
        }
        
        // Check app alerts
        let appAlert: XCUIElement
        if exactMatch {
            appAlert = app.alerts[title]
        } else {
            let predicate = NSPredicate(format: "label CONTAINS[c] %@", title)
            appAlert = app.alerts.containing(predicate).firstMatch
        }
        
        if appAlert.waitForExistence(timeout: timeoutValue) {
            return appAlert
        }
        
        return nil
    }
    
    /// Wait for alert matching a pattern
    /// - Parameters:
    ///   - pattern: Regular expression pattern to match
    ///   - timeout: Custom timeout (uses default if nil)
    /// - Returns: Alert element if found, nil otherwise
    @discardableResult
    func waitForAlert(matchingPattern pattern: String, timeout: TimeInterval? = nil) -> XCUIElement? {
        let timeoutValue = timeout ?? defaultTimeout
        let predicate = NSPredicate(format: "label MATCHES %@", pattern)
        
        // Check springboard alerts
        let springboardAlert = springboard.alerts.containing(predicate).firstMatch
        if springboardAlert.waitForExistence(timeout: timeoutValue) {
            return springboardAlert
        }
        
        // Check app alerts
        let appAlert = app.alerts.containing(predicate).firstMatch
        if appAlert.waitForExistence(timeout: timeoutValue) {
            return appAlert
        }
        
        return nil
    }
    
    // MARK: - Alert Verification
    
    /// Verify that an alert exists
    /// - Parameters:
    ///   - timeout: Custom timeout (uses default if nil)
    ///   - file: Source file (for assertion)
    ///   - line: Line number (for assertion)
    func verifyAlertExists(timeout: TimeInterval? = nil, file: StaticString = #file, line: UInt = #line) {
        let alert = waitForAlert(timeout: timeout)
        XCTAssertTrue(alert != nil, "Alert should exist", file: file, line: line)
    }
    
    /// Verify that an alert with specific title exists
    /// - Parameters:
    ///   - title: Alert title to search for
    ///   - exactMatch: If true, requires exact match; if false, uses contains
    ///   - timeout: Custom timeout (uses default if nil)
    ///   - file: Source file (for assertion)
    ///   - line: Line number (for assertion)
    func verifyAlertExists(withTitle title: String, exactMatch: Bool = false, timeout: TimeInterval? = nil, file: StaticString = #file, line: UInt = #line) {
        let alert = waitForAlert(withTitle: title, exactMatch: exactMatch, timeout: timeout)
        XCTAssertTrue(alert != nil, "Alert with title '\(title)' should exist", file: file, line: line)
    }
    
    /// Verify that no alert exists
    /// - Parameters:
    ///   - file: Source file (for assertion)
    ///   - line: Line number (for assertion)
    func verifyNoAlertExists(file: StaticString = #file, line: UInt = #line) {
        let springboardAlert = springboard.alerts.firstMatch
        let appAlert = app.alerts.firstMatch
        XCTAssertFalse(springboardAlert.exists || appAlert.exists, "No alert should exist", file: file, line: line)
    }
    
    // MARK: - Alert Interaction
    
    /// Tap button in alert by label
    /// - Parameters:
    ///   - buttonLabel: Button label to tap
    ///   - alert: Alert element (uses first match if nil)
    ///   - waitForDismissal: Wait for alert to dismiss after tapping
    /// - Returns: True if button was tapped
    @discardableResult
    func tapButton(_ buttonLabel: String, in alert: XCUIElement? = nil, waitForDismissal: Bool = true) -> Bool {
        let alertElement = alert ?? firstAlert
        
        guard let alertElement = alertElement, alertElement.exists else {
            print("⚠️ Alert not found")
            return false
        }
        
        let button = alertElement.buttons[buttonLabel]
        if button.exists {
            button.tap()
            
            if waitForDismissal {
                Thread.sleep(forTimeInterval: 1.0)
                // Verify alert dismissed
                if alertElement.exists {
                    print("⚠️ Alert still exists after tapping button")
                }
            }
            return true
        }
        
        print("⚠️ Button '\(buttonLabel)' not found in alert")
        return false
    }
    
    /// Tap OK button in alert
    /// - Parameter alert: Alert element (uses first match if nil)
    /// - Returns: True if OK button was tapped
    @discardableResult
    func tapOK(in alert: XCUIElement? = nil) -> Bool {
        return tapButton("OK", in: alert)
    }
    
    /// Tap Cancel button in alert
    /// - Parameter alert: Alert element (uses first match if nil)
    /// - Returns: True if Cancel button was tapped
    @discardableResult
    func tapCancel(in alert: XCUIElement? = nil) -> Bool {
        return tapButton("Cancel", in: alert)
    }
    
    /// Tap Allow button in alert (for permissions)
    /// - Parameter alert: Alert element (uses first match if nil)
    /// - Returns: True if Allow button was tapped
    @discardableResult
    func tapAllow(in alert: XCUIElement? = nil) -> Bool {
        return tapButton("Allow", in: alert)
    }
    
    /// Tap Don't Allow button in alert (for permissions)
    /// - Parameter alert: Alert element (uses first match if nil)
    /// - Returns: True if Don't Allow button was tapped
    @discardableResult
    func tapDontAllow(in alert: XCUIElement? = nil) -> Bool {
        return tapButton("Don't Allow", in: alert)
    }
    
    /// Dismiss alert by tapping first button
    /// - Parameter alert: Alert element (uses first match if nil)
    /// - Returns: True if button was tapped
    @discardableResult
    func dismissAlert(alert: XCUIElement? = nil) -> Bool {
        let alertElement = alert ?? firstAlert
        
        guard let alertElement = alertElement, alertElement.exists else {
            return false
        }
        
        let firstButton = alertElement.buttons.element(boundBy: 0)
        if firstButton.exists {
            firstButton.tap()
            Thread.sleep(forTimeInterval: 1.0)
            return true
        }
        
        return false
    }
    
    // MARK: - Alert Information
    
    /// Get alert title/label
    /// - Parameter alert: Alert element (uses first match if nil)
    /// - Returns: Alert title
    func getAlertTitle(from alert: XCUIElement? = nil) -> String {
        let alertElement = alert ?? firstAlert
        return alertElement?.label ?? ""
    }
    
    /// Get all button labels from alert
    /// - Parameter alert: Alert element (uses first match if nil)
    /// - Returns: Array of button labels
    func getAlertButtons(from alert: XCUIElement? = nil) -> [String] {
        let alertElement = alert ?? firstAlert
        
        guard let alertElement = alertElement, alertElement.exists else {
            return []
        }
        
        var buttonLabels: [String] = []
        for button in alertElement.buttons.allElementsBoundByIndex {
            if button.exists {
                buttonLabels.append(button.label)
            }
        }
        return buttonLabels
    }
    
    /// Get alert message text
    /// - Parameter alert: Alert element (uses first match if nil)
    /// - Returns: Array of static text labels
    func getAlertMessages(from alert: XCUIElement? = nil) -> [String] {
        let alertElement = alert ?? firstAlert
        
        guard let alertElement = alertElement, alertElement.exists else {
            return []
        }
        
        var messages: [String] = []
        for text in alertElement.staticTexts.allElementsBoundByIndex {
            if text.exists {
                messages.append(text.label)
            }
        }
        return messages
    }
    
    /// Check if alert exists
    /// - Returns: True if any alert exists
    func hasAlert() -> Bool {
        return springboard.alerts.firstMatch.exists || app.alerts.firstMatch.exists
    }
    
    /// Get count of visible alerts
    /// - Returns: Number of visible alerts
    func getAlertCount() -> Int {
        return springboard.alerts.count + app.alerts.count
    }
    
    // MARK: - Debug Methods
    
    /// Print all visible alerts
    func printAllAlerts() {
        print("\n🔔 VISIBLE ALERTS:")
        print(String(repeating: "-", count: 60))
        
        let springboardCount = springboard.alerts.count
        let appCount = app.alerts.count
        
        print("Springboard alerts: \(springboardCount)")
        print("App alerts: \(appCount)")
        
        if springboardCount > 0 {
            print("\nSpringboard Alerts:")
            for (index, alert) in springboard.alerts.allElementsBoundByIndex.enumerated() {
                if alert.exists {
                    print("  [\(index)] \(alert.label)")
                    printAlertDetails(alert: alert)
                }
            }
        }
        
        if appCount > 0 {
            print("\nApp Alerts:")
            for (index, alert) in app.alerts.allElementsBoundByIndex.enumerated() {
                if alert.exists {
                    print("  [\(index)] \(alert.label)")
                    printAlertDetails(alert: alert)
                }
            }
        }
        
        print(String(repeating: "-", count: 60) + "\n")
    }
    
    /// Print alert details
    /// - Parameter alert: Alert element
    func printAlertDetails(alert: XCUIElement) {
        print("    Title: \(alert.label)")
        
        let messages = getAlertMessages(from: alert)
        if !messages.isEmpty {
            print("    Messages:")
            for message in messages {
                print("      - \(message)")
            }
        }
        
        let buttons = getAlertButtons(from: alert)
        if !buttons.isEmpty {
            print("    Buttons:")
            for button in buttons {
                print("      - \(button)")
            }
        }
    }
    
    // MARK: - Helper Methods
    
    /// Wait for a specified duration
    /// - Parameter duration: Time to wait in seconds
    func wait(_ duration: TimeInterval) {
        Thread.sleep(forTimeInterval: duration)
    }
}
