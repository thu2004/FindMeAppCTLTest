//
//  NotificationTests.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Test class demonstrating notification testing with NotificationHelper
final class NotificationTests: XCTestCase {
    
    // MARK: - Properties
    
    private var app: XCUIApplication!
    private var notificationHelper: NotificationHelper!
    
    // MARK: - Setup & Teardown
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        // Initialize notification helper
        notificationHelper = NotificationHelper(timeout: 15.0)
        
        // Launch the app
        TestContext.shared.launchFindMyApp()
        app = TestContext.shared.getFindMyApp()
    }
    
    override func tearDownWithError() throws {
        // Clear all notifications after each test
        notificationHelper.clearAllNotifications()
        
        TestContext.shared.terminateFindMyApp()
    }
    
    // MARK: - Example Tests
    
    @MainActor
    func testWaitForNotificationWithText() throws {
        // Example: Wait for a notification containing "FindMy"
        print("🔔 Waiting for notification with 'FindMy'...")
        
        let notification = notificationHelper.waitForNotification(withText: "FindMy", timeout: 10.0)
        
        if let notification = notification {
            print("✅ Notification found: \(notification.label)")
            XCTAssertTrue(notification.exists, "Notification should exist")
        } else {
            XCTAssertTrue(false, "No notification found within timeout")
        }
    }
    
    @MainActor
    func testWaitForNotificationWithOpenCenter() throws {
        // Example: Open notification center first, then wait
        print("🔔 Opening notification center and waiting for notification...")
        
        let notification = notificationHelper.waitForNotification(
            withText: "FindMy",
            timeout: 10.0,
            openCenter: true
        )
        
        if let notification = notification {
            print("✅ Notification found: \(notification.label)")
            XCTAssertTrue(notification.exists, "Notification should exist")
        } else {
            XCTFail("No notification found within timeout")
        }
        
        // Close notification center
        notificationHelper.closeNotificationCenter()
    }
    
    @MainActor
    func testWaitForNotificationMatchingPattern() throws {
        // Example: Wait for notification matching a pattern
        // Pattern: Any notification containing "found" or "located"
        print("🔔 Waiting for notification matching pattern...")
        
        let pattern = ".*(found|located).*"
        let notification = notificationHelper.waitForNotification(matchingPattern: pattern, timeout: 10.0)
        
        if let notification = notification {
            print("✅ Notification found: \(notification.label)")
            XCTAssertTrue(notification.exists, "Notification should exist")
        } else {
            XCTFail("No notification matching pattern '\(pattern)' found")
        }
    }
    
    @MainActor
    func testWaitForNotificationFromApp() throws {
        // Example: Wait for notification from FindMy app
        print("🔔 Waiting for notification from FindMy app...")
        
        let notification = notificationHelper.waitForNotification(fromApp: "FindMy", timeout: 10.0)
        
        if let notification = notification {
            print("✅ Notification from FindMy found: \(notification.label)")
            XCTAssertTrue(notification.exists, "Notification should exist")
        } else {
            XCTFail("No notification from FindMy app found")
        }
    }
    
    @MainActor
    func testVerifyNotificationExists() throws {
        // Example: Verify notification exists (will fail test if not found)
        print("🔔 Verifying notification exists...")
        
        // This will wait and assert that notification exists
        notificationHelper.verifyNotificationExists(withText: "Sound playing", timeout: 10.0)
        
        print("✅ Notification verification passed")
    }
    
    @MainActor
    func testTapNotification() throws {
        // Example: Tap on a notification
        print("🔔 Waiting for notification to tap...")
        
        let tapped = notificationHelper.tapNotification(withText: "FindMy", timeout: 10.0)
        
        if tapped {
            print("✅ Notification tapped successfully")
            XCTAssertTrue(tapped, "Notification should be tapped")
        } else {
            XCTFail("Failed to tap notification - notification not found")
        }
    }
    
    @MainActor
    func testDismissNotification() throws {
        // Example: Dismiss a notification by swiping
        print("🔔 Waiting for notification to dismiss...")
        
        let dismissed = notificationHelper.dismissNotification(withText: "FindMy", direction: .up, timeout: 10.0)
        
        if dismissed {
            print("✅ Notification dismissed successfully")
            XCTAssertTrue(dismissed, "Notification should be dismissed")
        } else {
            XCTFail("Failed to dismiss notification - notification not found")
        }
    }
    
    @MainActor
    func testClearAllNotifications() throws {
        // Example: Clear all notifications
        print("🔔 Clearing all notifications...")
        
        notificationHelper.clearAllNotifications()
        notificationHelper.wait(2.0)
        
        // Verify no notifications remain
        let hasNotifications = notificationHelper.hasNotifications()
        XCTAssertFalse(hasNotifications, "All notifications should be cleared")
        
        print("✅ All notifications cleared")
    }
    
    @MainActor
    func testGetNotificationCount() throws {
        // Example: Get count of visible notifications
        print("🔔 Checking notification count...")
        
        let count = notificationHelper.getNotificationCount()
        print("📊 Found \(count) notification(s)")
        
        XCTAssertGreaterThanOrEqual(count, 0, "Count should be non-negative")
    }
    
    @MainActor
    func testPrintAllNotifications() throws {
        // Example: Print all visible notifications for debugging
        print("🔔 Printing all notifications...")
        
        notificationHelper.printAllNotifications()
        
        let texts = notificationHelper.getAllNotificationTexts()
        print("📝 Retrieved \(texts.count) notification text(s)")
    }
    
    // MARK: - Real-World Example: Play Sound and Wait for Notification
    
    @MainActor
    func testPlaySoundAndWaitForNotification() throws {
        let mainPage = FindMyMainPage(app: app)
        
        // Navigate to Devices tab
        mainPage.verifyMainPageIsDisplayed()
        mainPage.navigateToDevicesTab()
        
        // Tap on first device
        let deviceDetailPage = mainPage.tapFirstDevice()
        deviceDetailPage.verifyDetailPageIsDisplayed()
        
        // Clear any existing notifications first
        notificationHelper.clearAllNotifications()
        notificationHelper.wait(1.0)
        
        // Play sound on device
        print("🔊 Playing sound on device...")
        deviceDetailPage.playSound()
        
        // Wait for notification about sound playing
        print("🔔 Waiting for sound notification...")
        let notification = notificationHelper.waitForNotification(
            matchingPattern: ".*(sound|playing|Sound).*",
            timeout: 15.0
        )
        
        if let notification = notification {
            print("✅ Sound notification received: \(notification.label)")
            XCTAssertTrue(notification.exists, "Sound notification should appear")
        } else {
            print("⚠️ No sound notification received (this may be expected)")
        }
        
        // Wait for sound to finish
        notificationHelper.wait(5.0)
        
        // Close device detail
        deviceDetailPage.tapCloseButton()
        mainPage.wait(1.0)
    }
    
    // MARK: - Real-World Example: Verify No Unwanted Notifications
    
    @MainActor
    func testVerifyNoErrorNotifications() throws {
        let mainPage = FindMyMainPage(app: app)
        
        // Perform some actions
        mainPage.verifyMainPageIsDisplayed()
        mainPage.navigateToDevicesTab()
        mainPage.wait(2.0)
        
        // Verify no error notifications appeared
        print("🔔 Checking for error notifications...")
        notificationHelper.verifyNotificationDoesNotExist(withText: "error")
        notificationHelper.verifyNotificationDoesNotExist(withText: "failed")
        
        print("✅ No error notifications found")
    }
    
    // MARK: - Real-World Example: Wait for Multiple Notifications
    
    @MainActor
    func testWaitForMultipleNotifications() throws {
        print("🔔 Waiting for multiple notifications...")
        
        // Wait for first notification
        if notificationHelper.waitForNotification(timeout: 10.0) {
            print("✅ First notification appeared")
            
            // Get count
            let count = notificationHelper.getNotificationCount()
            print("📊 Total notifications: \(count)")
            
            // Print all for debugging
            notificationHelper.printAllNotifications()
            
            // Clear specific notification
            let cleared = notificationHelper.clearNotification(withText: "FindMy")
            if cleared {
                print("✅ Cleared FindMy notification")
            }
        }
    }
}
