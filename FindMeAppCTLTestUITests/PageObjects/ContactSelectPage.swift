//
//  ContactSelectPage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Page Object for selecting contacts in FindMy app
/// Used for sharing location or items with contacts
class ContactSelectPage: BasePage {
    
    // MARK: - Identifiers
    
    private let shareMyLocationIdentifier = "ActivityIndicatingNavigation"
    
    // MARK: - Labels
    
    private let cancelButtonLabel = "Cancel"
    private let sendButtonLabel = "Done"
    private let addContactButtonLabel = "Add Contact"
    
    // MARK: - Elements
    
    /// Base element for contact select view
    var baseElement: XCUIElement {
        return app.otherElements.matching(identifier: shareMyLocationIdentifier).firstMatch
    }
    
    /// Cancel button
    var cancelButton: XCUIElement {
        return baseElement.buttons[cancelButtonLabel].firstMatch
    }
    
    /// Send/Done button
    var sendButton: XCUIElement {
        return baseElement.buttons[sendButtonLabel].firstMatch
    }
    
    /// Add Contact button
    var addContactButton: XCUIElement {
        return baseElement.buttons[addContactButtonLabel].firstMatch
    }
    
    /// To field (search/input field)
    var toField: XCUIElement {
        return baseElement.textFields.firstMatch
    }
    
    /// Results list (table of contacts)
    var resultsList: XCUIElement {
        return baseElement.tables.firstMatch
    }
    
    // MARK: - Verification
    
    /// Verify the contact select page is displayed
    func verifyContactSelectPageIsDisplayed() {
        XCTAssertTrue(baseElement.waitForExistence(timeout: defaultTimeout),
                     "Contact select page should be displayed")
        XCTAssertTrue(toField.exists, "To field should exist")
    }
    
    /// Check if contact select page is displayed
    /// - Returns: True if contact select page is visible
    func isContactSelectPageDisplayed() -> Bool {
        return baseElement.exists && toField.exists
    }
    
    // MARK: - Actions
    
    /// Enter contact name or email in search field
    /// - Parameter contact: Contact name or email
    func enterContact(_ contact: String) {
        XCTAssertTrue(toField.waitForExistence(timeout: defaultTimeout),
                     "To field should exist")
        toField.tap()
        toField.typeText(contact)
        wait(1.0) // Wait for search results
    }
    
    /// Select contact from results list by name
    /// - Parameter name: Contact name to select
    func selectContact(byName name: String) {
        XCTAssertTrue(resultsList.waitForExistence(timeout: defaultTimeout),
                     "Results list should exist")
        
        let contactCell = resultsList.cells.containing(
            NSPredicate(format: "label CONTAINS[c] %@", name)
        ).firstMatch
        
        XCTAssertTrue(contactCell.waitForExistence(timeout: defaultTimeout),
                     "Contact '\(name)' should exist in results")
        contactCell.tap()
        wait(0.5)
    }
    
    /// Select first contact from results
    func selectFirstContact() {
        XCTAssertTrue(resultsList.waitForExistence(timeout: defaultTimeout),
                     "Results list should exist")
        
        let firstCell = resultsList.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "First contact should exist")
        firstCell.tap()
        wait(0.5)
    }
    
    /// Tap Send/Done button
    func tapSend() {
        XCTAssertTrue(sendButton.waitForExistence(timeout: defaultTimeout),
                     "Send button should exist")
        sendButton.tap()
        wait(1.0)
    }
    
    /// Tap Cancel button
    func tapCancel() {
        XCTAssertTrue(cancelButton.waitForExistence(timeout: defaultTimeout),
                     "Cancel button should exist")
        cancelButton.tap()
        wait(1.0)
    }
    
    /// Tap Add Contact button
    func tapAddContact() {
        XCTAssertTrue(addContactButton.waitForExistence(timeout: defaultTimeout),
                     "Add Contact button should exist")
        addContactButton.tap()
        wait(1.0)
    }
    
    /// Select contact and send
    /// - Parameter contact: Contact name or email
    func selectAndSendContact(_ contact: String) {
        verifyContactSelectPageIsDisplayed()
        enterContact(contact)
        selectFirstContact()
        tapSend()
    }
    
    /// Get number of contacts in results
    /// - Returns: Number of contacts
    func getContactCount() -> Int {
        if resultsList.exists {
            return resultsList.cells.count
        }
        return 0
    }
    
    /// Check if contact exists in results
    /// - Parameter name: Contact name
    /// - Returns: True if contact exists
    func contactExists(_ name: String) -> Bool {
        if !resultsList.exists {
            return false
        }
        
        let contactCell = resultsList.cells.containing(
            NSPredicate(format: "label CONTAINS[c] %@", name)
        ).firstMatch
        
        return contactCell.exists
    }
}
