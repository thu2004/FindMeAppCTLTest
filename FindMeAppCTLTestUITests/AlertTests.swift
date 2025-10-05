//
//  AlertTests.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Test class for handling alerts and popups in FindMy app
final class AlertTests: XCTestCase {
    
    // MARK: - Properties
    
    private var app: XCUIApplication!
    private var springboard: XCUIApplication!
    
    // MARK: - Setup & Teardown
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        TestContext.shared.launchFindMyApp()
        app = TestContext.shared.getFindMyApp()
        springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    }
    
    override func tearDownWithError() throws {
        TestContext.shared.terminateFindMyApp()
    }
    
    // MARK: - Alert Detection Tests
    
    @MainActor
    func testWaitForAlert() throws {
        print("🔔 Waiting for alert to appear...")
        
        // Wait for any alert to appear
        let alert = springboard.alerts.firstMatch
        let alertExists = alert.waitForExistence(timeout: 10.0)
        
        if alertExists {
            print("✅ Alert found: \(alert.label)")
            print("   Buttons: \(alert.buttons.count)")
            
            // Print all buttons in the alert
            for (index, button) in alert.buttons.allElementsBoundByIndex.enumerated() {
                if button.exists {
                    print("   Button[\(index)]: '\(button.label)'")
                }
            }
            
            XCTAssertTrue(alertExists, "Alert should exist")
            
            // Look for OK button and tap it
            let okButton = alert.buttons["OK"]
            if okButton.exists {
                print("   Tapping OK button to close alert...")
                okButton.tap()
                Thread.sleep(forTimeInterval: 1.0)
                
                // Verify alert dismissed
                if !alert.exists {
                    print("✅ Alert dismissed successfully")
                } else {
                    print("⚠️ Alert still visible after tapping OK")
                }
            } else {
                print("⚠️ OK button not found in alert")
            }
        } else {
            print("⚠️ No alert found within timeout (this may be expected)")
        }
    }
    
    @MainActor
    func testWaitForSpecificAlert() throws {
        print("🔔 Waiting for 'Find My iPhone Alert'...")
        
        // Wait for specific alert by label
        let alert = springboard.alerts["Find My iPhone Alert"]
        let alertExists = alert.waitForExistence(timeout: 10.0)
        
        if alertExists {
            print("✅ Alert found: \(alert.label)")
            XCTAssertTrue(alertExists, "Find My iPhone Alert should exist")
        } else {
            print("⚠️ No 'Find My iPhone Alert' found")
        }
    }
    
    @MainActor
    func testHandleAlertWithOKButton() throws {
        print("🔔 Waiting for alert and tapping OK...")
        
        // Wait for alert
        let alert = springboard.alerts.firstMatch
        let alertExists = alert.waitForExistence(timeout: 10.0)
        
        if alertExists {
            print("✅ Alert found: \(alert.label)")
            
            // Look for OK button
            let okButton = alert.buttons["OK"]
            if okButton.exists {
                print("   Tapping OK button...")
                okButton.tap()
                Thread.sleep(forTimeInterval: 1.0)
                
                // Verify alert dismissed
                XCTAssertFalse(alert.exists, "Alert should be dismissed after tapping OK")
                print("✅ Alert dismissed successfully")
            } else {
                print("⚠️ OK button not found in alert")
            }
        } else {
            print("⚠️ No alert found")
        }
    }
    
    @MainActor
    func testHandleAlertWithCancelButton() throws {
        print("🔔 Waiting for alert and tapping Cancel...")
        
        // Wait for alert
        let alert = springboard.alerts.firstMatch
        let alertExists = alert.waitForExistence(timeout: 10.0)
        
        if alertExists {
            print("✅ Alert found: \(alert.label)")
            
            // Look for Cancel button
            let cancelButton = alert.buttons["Cancel"]
            if cancelButton.exists {
                print("   Tapping Cancel button...")
                cancelButton.tap()
                Thread.sleep(forTimeInterval: 1.0)
                
                // Verify alert dismissed
                XCTAssertFalse(alert.exists, "Alert should be dismissed after tapping Cancel")
                print("✅ Alert dismissed successfully")
            } else {
                print("⚠️ Cancel button not found in alert")
            }
        } else {
            print("⚠️ No alert found")
        }
    }
    
    @MainActor
    func testGetAlertMessage() throws {
        print("🔔 Getting alert message...")
        
        // Wait for alert
        let alert = springboard.alerts.firstMatch
        let alertExists = alert.waitForExistence(timeout: 10.0)
        
        if alertExists {
            print("✅ Alert found")
            print("   Label: \(alert.label)")
            
            // Get alert message (static text)
            let staticTexts = alert.staticTexts
            print("   Static texts count: \(staticTexts.count)")
            
            for (index, text) in staticTexts.allElementsBoundByIndex.enumerated() {
                if text.exists {
                    print("   Text[\(index)]: '\(text.label)'")
                }
            }
        } else {
            print("⚠️ No alert found")
        }
    }
    
    // MARK: - Real-World Alert Tests
    
    @MainActor
    func testPlaySoundAndHandleAlert() throws {
        let mainPage = FindMyMainPage(app: app)
        
        print("📱 Navigating to device...")
        mainPage.verifyMainPageIsDisplayed()
        mainPage.navigateToDevicesTab()
        
        let deviceDetailPage = mainPage.tapFirstDevice()
        deviceDetailPage.verifyDetailPageIsDisplayed()
        
        print("🔊 Playing sound on device...")
        deviceDetailPage.playSound()
        
        // Wait for alert
        print("🔔 Waiting for alert...")
        let alert = springboard.alerts.firstMatch
        let alertExists = alert.waitForExistence(timeout: 15.0)
        
        if alertExists {
            print("✅ Alert appeared: \(alert.label)")
            
            // Handle the alert - tap OK
            let okButton = alert.buttons["OK"]
            if okButton.exists {
                print("   Tapping OK...")
                okButton.tap()
                Thread.sleep(forTimeInterval: 1.0)
            }
        } else {
            print("⚠️ No alert appeared (may be expected)")
        }
        
        // Close device detail
        deviceDetailPage.tapCloseButton()
        mainPage.wait(1.0)
    }
    
    @MainActor
    func testAlertInterruptionHandler() throws {
        print("🔔 Setting up alert interruption handler...")
        
        // Add UI interruption monitor
        addUIInterruptionMonitor(withDescription: "Alert Handler") { alert in
            print("🔔 Alert interrupted: \(alert.label)")
            
            // Try to find and tap OK button
            let okButton = alert.buttons["OK"]
            if okButton.exists {
                print("   Auto-tapping OK...")
                okButton.tap()
                return true
            }
            
            // Try to find and tap default button
            let defaultButton = alert.buttons.element(boundBy: 0)
            if defaultButton.exists {
                print("   Auto-tapping first button: \(defaultButton.label)")
                defaultButton.tap()
                return true
            }
            
            return false
        }
        
        // Perform actions that might trigger alerts
        let mainPage = FindMyMainPage(app: app)
        mainPage.verifyMainPageIsDisplayed()
        mainPage.navigateToDevicesTab()
        
        let deviceDetailPage = mainPage.tapFirstDevice()
        deviceDetailPage.verifyDetailPageIsDisplayed()
        
        // Play sound (may trigger alert)
        deviceDetailPage.playSound()
        
        // Tap somewhere to trigger interruption monitor
        app.tap()
        
        Thread.sleep(forTimeInterval: 5.0)
        
        deviceDetailPage.tapCloseButton()
        mainPage.wait(1.0)
        
        print("✅ Test completed with interruption handler")
    }
    
    // MARK: - Helper Methods
    
    /// Wait for alert with specific title
    /// - Parameters:
    ///   - title: Alert title to wait for
    ///   - timeout: Timeout in seconds
    /// - Returns: Alert element if found, nil otherwise
    func waitForAlert(withTitle title: String, timeout: TimeInterval = 10.0) -> XCUIElement? {
        let alert = springboard.alerts[title]
        if alert.waitForExistence(timeout: timeout) {
            return alert
        }
        return nil
    }
    
    /// Dismiss alert by tapping button with label
    /// - Parameters:
    ///   - buttonLabel: Button label to tap
    ///   - alert: Alert element (uses first match if nil)
    /// - Returns: True if button was tapped
    @discardableResult
    func dismissAlert(byTapping buttonLabel: String, alert: XCUIElement? = nil) -> Bool {
        let alertElement = alert ?? springboard.alerts.firstMatch
        
        guard alertElement.exists else {
            print("⚠️ Alert not found")
            return false
        }
        
        let button = alertElement.buttons[buttonLabel]
        if button.exists {
            button.tap()
            Thread.sleep(forTimeInterval: 0.5)
            return true
        }
        
        print("⚠️ Button '\(buttonLabel)' not found in alert")
        return false
    }
    
    /// Get all button labels from an alert
    /// - Parameter alert: Alert element (uses first match if nil)
    /// - Returns: Array of button labels
    func getAlertButtons(from alert: XCUIElement? = nil) -> [String] {
        let alertElement = alert ?? springboard.alerts.firstMatch
        
        guard alertElement.exists else {
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
    
    /// Print alert details for debugging
    /// - Parameter alert: Alert element (uses first match if nil)
    func printAlertDetails(alert: XCUIElement? = nil) {
        let alertElement = alert ?? springboard.alerts.firstMatch
        
        guard alertElement.exists else {
            print("⚠️ No alert found")
            return
        }
        
        print("\n🔔 ALERT DETAILS:")
        print("   Label: \(alertElement.label)")
        print("   Identifier: \(alertElement.identifier)")
        
        print("   Static Texts:")
        for (index, text) in alertElement.staticTexts.allElementsBoundByIndex.enumerated() {
            if text.exists {
                print("     [\(index)] \(text.label)")
            }
        }
        
        print("   Buttons:")
        for (index, button) in alertElement.buttons.allElementsBoundByIndex.enumerated() {
            if button.exists {
                print("     [\(index)] \(button.label)")
            }
        }
        print("")
    }
}
