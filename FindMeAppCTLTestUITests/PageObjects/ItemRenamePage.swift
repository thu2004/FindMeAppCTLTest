//
//  ItemRenamePage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Page Object for renaming items in FindMy app
/// Handles the rename flow for AirTags and other items
class ItemRenamePage: BasePage {
    
    // MARK: - Labels
    
    private let cancelButtonLabel = "Cancel"
    private let doneButtonLabel = "Done"
    private let clearTextButtonLabel = "Close"
    
    // MARK: - Identifiers
    
    private let baseElementIdentifier = "ActivityIndicatingNavigation"
    
    // MARK: - Elements
    
    /// Base element for rename view
    var baseElement: XCUIElement {
        return app.otherElements[baseElementIdentifier].firstMatch
    }
    
    /// Done button
    var doneButton: XCUIElement {
        return app.buttons[doneButtonLabel].firstMatch
    }
    
    /// Cancel button
    var cancelButton: XCUIElement {
        return app.buttons[cancelButtonLabel].firstMatch
    }
    
    /// Clear text button (X button in text field)
    var clearTextButton: XCUIElement {
        return baseElement.buttons[clearTextButtonLabel].firstMatch
    }
    
    /// Name text field
    var nameTextField: XCUIElement {
        return app.textViews.firstMatch
    }
    
    // MARK: - Verification
    
    /// Verify the rename page is displayed
    func verifyRenamePageIsDisplayed() {
        XCTAssertTrue(baseElement.waitForExistence(timeout: defaultTimeout),
                     "Rename page should be displayed")
        XCTAssertTrue(nameTextField.exists, "Name text field should exist")
    }
    
    /// Check if rename page is displayed
    /// - Returns: True if rename page is visible
    func isRenamePageDisplayed() -> Bool {
        return baseElement.exists && nameTextField.exists
    }
    
    // MARK: - Actions
    
    /// Enter new name for item
    /// - Parameter name: New name to enter
    func enterName(_ name: String) {
        XCTAssertTrue(nameTextField.waitForExistence(timeout: defaultTimeout),
                     "Name text field should exist")
        
        // Clear existing text
        nameTextField.tap()
        
        // Select all and delete
        if clearTextButton.exists {
            clearTextButton.tap()
        } else {
            // Fallback: select all and delete
            nameTextField.typeText(XCUIKeyboardKey.command.rawValue + "a")
            nameTextField.typeText(XCUIKeyboardKey.delete.rawValue)
        }
        
        // Enter new name
        nameTextField.typeText(name)
        wait(0.5)
    }
    
    /// Tap Done button to save changes
    func tapDone() {
        XCTAssertTrue(doneButton.waitForExistence(timeout: defaultTimeout),
                     "Done button should exist")
        doneButton.tap()
        wait(1.0)
    }
    
    /// Tap Cancel button to discard changes
    func tapCancel() {
        XCTAssertTrue(cancelButton.waitForExistence(timeout: defaultTimeout),
                     "Cancel button should exist")
        cancelButton.tap()
        wait(1.0)
    }
    
    /// Clear the text field
    func clearText() {
        if clearTextButton.waitForExistence(timeout: defaultTimeout) {
            clearTextButton.tap()
            wait(0.5)
        }
    }
    
    /// Rename item with new name
    /// - Parameter name: New name for the item
    func renameItem(to name: String) {
        verifyRenamePageIsDisplayed()
        enterName(name)
        tapDone()
    }
}
