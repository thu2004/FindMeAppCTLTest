//
//  ItemSharingPage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Page Object for item sharing functionality in FindMy app
/// Handles sharing AirTags and other items with contacts
class ItemSharingPage: BasePage {
    
    // MARK: - Identifiers
    
    private let continueButtonIdentifier = "Continue Button"
    
    // MARK: - Labels
    
    private let cancelLabel = "Cancel"
    private let doneLabel = "Done"
    private let shareLabel = "Share"
    
    // MARK: - Elements
    
    /// Continue button
    var continueButton: XCUIElement {
        return app.buttons[continueButtonIdentifier].firstMatch
    }
    
    /// Cancel button
    var cancelButton: XCUIElement {
        return app.buttons[cancelLabel].firstMatch
    }
    
    /// Done button
    var doneButton: XCUIElement {
        return app.buttons[doneLabel].firstMatch
    }
    
    /// Share button
    var shareButton: XCUIElement {
        return app.buttons[shareLabel].firstMatch
    }
    
    // MARK: - Verification
    
    /// Verify the item sharing page is displayed
    func verifyItemSharingPageIsDisplayed() {
        XCTAssertTrue(continueButton.waitForExistence(timeout: defaultTimeout) || 
                     shareButton.waitForExistence(timeout: defaultTimeout),
                     "Item sharing page should be displayed")
    }
    
    /// Check if item sharing page is displayed
    /// - Returns: True if item sharing page is visible
    func isItemSharingPageDisplayed() -> Bool {
        return continueButton.exists || shareButton.exists
    }
    
    // MARK: - Actions
    
    /// Tap Continue button
    func tapContinue() {
        XCTAssertTrue(continueButton.waitForExistence(timeout: defaultTimeout),
                     "Continue button should exist")
        continueButton.tap()
        wait(1.0)
    }
    
    /// Tap Share button
    func tapShare() {
        XCTAssertTrue(shareButton.waitForExistence(timeout: defaultTimeout),
                     "Share button should exist")
        shareButton.tap()
        wait(1.0)
    }
    
    /// Tap Done button
    func tapDone() {
        XCTAssertTrue(doneButton.waitForExistence(timeout: defaultTimeout),
                     "Done button should exist")
        doneButton.tap()
        wait(1.0)
    }
    
    /// Tap Cancel button
    func tapCancel() {
        XCTAssertTrue(cancelButton.waitForExistence(timeout: defaultTimeout),
                     "Cancel button should exist")
        cancelButton.tap()
        wait(1.0)
    }
    
    /// Complete sharing flow
    func completeSharing() {
        verifyItemSharingPageIsDisplayed()
        
        if continueButton.exists {
            tapContinue()
        }
        
        if shareButton.exists {
            tapShare()
        }
        
        if doneButton.waitForExistence(timeout: 5.0) {
            tapDone()
        }
    }
}

/// Page Object for item sharing response view
/// Handles accepting or declining shared items
class ItemSharingResponsePage: BasePage {
    
    // MARK: - Labels
    
    private let acceptLabel = "Accept"
    private let declineLabel = "Decline"
    private let notNowLabel = "Not Now"
    
    // MARK: - Elements
    
    /// Accept button
    var acceptButton: XCUIElement {
        return app.buttons[acceptLabel].firstMatch
    }
    
    /// Decline button
    var declineButton: XCUIElement {
        return app.buttons[declineLabel].firstMatch
    }
    
    /// Not Now button
    var notNowButton: XCUIElement {
        return app.buttons[notNowLabel].firstMatch
    }
    
    // MARK: - Verification
    
    /// Verify the sharing response page is displayed
    func verifySharingResponsePageIsDisplayed() {
        XCTAssertTrue(acceptButton.waitForExistence(timeout: defaultTimeout) ||
                     declineButton.waitForExistence(timeout: defaultTimeout),
                     "Sharing response page should be displayed")
    }
    
    // MARK: - Actions
    
    /// Tap Accept button
    func tapAccept() {
        XCTAssertTrue(acceptButton.waitForExistence(timeout: defaultTimeout),
                     "Accept button should exist")
        acceptButton.tap()
        wait(1.0)
    }
    
    /// Tap Decline button
    func tapDecline() {
        XCTAssertTrue(declineButton.waitForExistence(timeout: defaultTimeout),
                     "Decline button should exist")
        declineButton.tap()
        wait(1.0)
    }
    
    /// Tap Not Now button
    func tapNotNow() {
        XCTAssertTrue(notNowButton.waitForExistence(timeout: defaultTimeout),
                     "Not Now button should exist")
        notNowButton.tap()
        wait(1.0)
    }
}

/// Page Object for stopping item sharing
class StopSharingPage: BasePage {
    
    // MARK: - Labels
    
    private let stopSharingLabel = "Stop Sharing"
    private let cancelLabel = "Cancel"
    
    // MARK: - Elements
    
    /// Stop Sharing button
    var stopSharingButton: XCUIElement {
        return app.buttons[stopSharingLabel].firstMatch
    }
    
    /// Cancel button
    var cancelButton: XCUIElement {
        return app.buttons[cancelLabel].firstMatch
    }
    
    // MARK: - Actions
    
    /// Tap Stop Sharing button
    func tapStopSharing() {
        XCTAssertTrue(stopSharingButton.waitForExistence(timeout: defaultTimeout),
                     "Stop Sharing button should exist")
        stopSharingButton.tap()
        wait(1.0)
    }
    
    /// Tap Cancel button
    func tapCancel() {
        XCTAssertTrue(cancelButton.waitForExistence(timeout: defaultTimeout),
                     "Cancel button should exist")
        cancelButton.tap()
        wait(1.0)
    }
}
