//
//  RemoveObjectPage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Page Object for removing objects (items/devices) in FindMy app
/// Handles the removal confirmation flow
class RemoveObjectPage: BasePage {
    
    // MARK: - Identifiers
    
    private let removeObjectViewIdentifier = "ActionLandingView"
    private let landingPageTitleIdentifier = "TitleLabel"
    private let deviceNameIdentifier = "DeviceName"
    private let deviceOwnerIdentifier = "DeviceOwner"
    private let removeButtonIdentifier = "PerformButton"
    
    // MARK: - Labels
    
    private let cancelLabel = "Cancel"
    
    // MARK: - Elements
    
    /// Base element for remove view
    var baseElement: XCUIElement {
        return app.otherElements[removeObjectViewIdentifier].firstMatch
    }
    
    /// Landing page title
    var landingPageTitle: XCUIElement {
        return baseElement.staticTexts[landingPageTitleIdentifier].firstMatch
    }
    
    /// Device/Item name label
    var deviceName: XCUIElement {
        return baseElement.staticTexts[deviceNameIdentifier].firstMatch
    }
    
    /// Device/Item owner label
    var deviceOwner: XCUIElement {
        return baseElement.staticTexts[deviceOwnerIdentifier].firstMatch
    }
    
    /// Remove button
    var removeButton: XCUIElement {
        return baseElement.buttons[removeButtonIdentifier].firstMatch
    }
    
    /// Cancel button
    var cancelButton: XCUIElement {
        return baseElement.buttons[cancelLabel].firstMatch
    }
    
    /// In-progress activity indicator
    var inProgressIndicator: XCUIElement {
        return baseElement.activityIndicators.firstMatch
    }
    
    // MARK: - Verification
    
    /// Verify the remove page is displayed
    func verifyRemovePageIsDisplayed() {
        XCTAssertTrue(landingPageTitle.waitForExistence(timeout: defaultTimeout),
                     "Remove page should be displayed")
    }
    
    /// Check if remove page is displayed
    /// - Returns: True if remove page is visible
    func isRemovePageDisplayed() -> Bool {
        return baseElement.exists && landingPageTitle.exists
    }
    
    /// Verify object name is displayed
    /// - Parameter name: Expected object name
    func verifyObjectName(_ name: String) {
        XCTAssertTrue(deviceName.exists, "Device name should exist")
        XCTAssertTrue(deviceName.label.contains(name), 
                     "Device name should contain '\(name)'")
    }
    
    // MARK: - Actions
    
    /// Tap Remove button to confirm removal
    func tapRemove() {
        XCTAssertTrue(removeButton.waitForExistence(timeout: defaultTimeout),
                     "Remove button should exist")
        removeButton.tap()
        wait(2.0) // Wait for removal to complete
    }
    
    /// Tap Cancel button to cancel removal
    func tapCancel() {
        XCTAssertTrue(cancelButton.waitForExistence(timeout: defaultTimeout),
                     "Cancel button should exist")
        cancelButton.tap()
        wait(1.0)
    }
    
    /// Wait for removal to complete
    /// - Parameter timeout: Timeout in seconds
    func waitForRemovalToComplete(timeout: TimeInterval = 10.0) {
        // Wait for progress indicator to appear
        if inProgressIndicator.waitForExistence(timeout: 2.0) {
            // Wait for it to disappear
            let predicate = NSPredicate(format: "exists == false")
            let expectation = XCTNSPredicateExpectation(predicate: predicate, 
                                                         object: inProgressIndicator)
            let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
            XCTAssertEqual(result, .completed, "Removal should complete within timeout")
        }
        wait(1.0)
    }
    
    /// Remove object and wait for completion
    func removeObject() {
        verifyRemovePageIsDisplayed()
        tapRemove()
        waitForRemovalToComplete()
    }
    
    /// Get the title text
    /// - Returns: Title text
    func getTitleText() -> String {
        return landingPageTitle.label
    }
    
    /// Get the device/item name
    /// - Returns: Device/item name
    func getDeviceName() -> String {
        return deviceName.label
    }
    
    /// Get the owner name
    /// - Returns: Owner name
    func getOwnerName() -> String {
        return deviceOwner.label
    }
}
