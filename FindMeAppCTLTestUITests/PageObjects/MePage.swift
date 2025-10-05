//
//  MePage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Page Object for the Me tab in FindMy app
/// Handles user profile and settings related to the current user
class MePage: BasePage {
    
    // MARK: - Identifiers
    
    private let primaryLabelIdentifier = "PrimaryLabel"
    
    // MARK: - Labels
    
    private let clearIgnoredItemsLabel = "Clear Ignored Items"
    private let meLabel = "Me"
    
    // MARK: - Elements
    
    /// Clear Ignored Items button
    var clearIgnoredItemsButton: XCUIElement {
        return app.buttons[clearIgnoredItemsLabel].firstMatch
    }
    
    /// Me title label
    var meTitle: XCUIElement {
        return app.staticTexts.matching(
            NSPredicate(format: "identifier == %@ AND label CONTAINS[c] %@", 
                       primaryLabelIdentifier, meLabel)
        ).firstMatch
    }
    
    // MARK: - Verification
    
    /// Verify the Me page is displayed
    func verifyMePageIsDisplayed() {
        XCTAssertTrue(meTitle.waitForExistence(timeout: defaultTimeout), 
                     "Me page should be displayed")
    }
    
    /// Check if Me page is displayed
    /// - Returns: True if Me page is visible
    func isMePageDisplayed() -> Bool {
        return meTitle.exists
    }
    
    // MARK: - Actions
    
    /// Navigate to Me tab
    func navigateToMeTab() {
        let meTab = app.buttons["Me"].firstMatch
        if meTab.exists {
            meTab.tap()
            wait(1.0)
        }
    }
    
    /// Tap Clear Ignored Items button
    func tapClearIgnoredItems() {
        XCTAssertTrue(clearIgnoredItemsButton.waitForExistence(timeout: defaultTimeout),
                     "Clear Ignored Items button should exist")
        clearIgnoredItemsButton.tap()
        wait(1.0)
    }
    
    /// Handle Clear Ignored Items confirmation popup
    /// - Parameter confirm: True to confirm, false to cancel
    func handleClearIgnoredPopup(confirm: Bool = true) {
        let clearButton = app.buttons["Clear"].firstMatch
        let cancelButton = app.buttons["Cancel"].firstMatch
        
        if confirm {
            XCTAssertTrue(clearButton.waitForExistence(timeout: defaultTimeout),
                         "Clear button should exist in popup")
            clearButton.tap()
        } else {
            XCTAssertTrue(cancelButton.waitForExistence(timeout: defaultTimeout),
                         "Cancel button should exist in popup")
            cancelButton.tap()
        }
        wait(1.0)
    }
}
