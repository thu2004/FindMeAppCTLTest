//
//  AddItemPage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Page Object for adding items menu in FindMy app
/// Handles the add item flow (AirTag, Apple Pencil, Other Item)
class AddItemPage: BasePage {
    
    // MARK: - Identifiers
    
    private let addActionButtonIdentifier = "add"
    private let addItemButtonIdentifier = "Add Item Button"
    
    // MARK: - Labels
    
    private let addApplePencilButtonLabel = "Add Apple Pencil"
    private let addAirTagButtonLabel = "Add AirTag"
    private let addOtherItemButtonLabel = "Add Other Item"
    private let otherSupportedItemLabel = "Other Supported Item"
    private let shareMyLocationButtonLabel = "Share My Location"
    
    // MARK: - Elements
    
    /// Add action button (+ button)
    var addActionButton: XCUIElement {
        return app.buttons.containing(
            NSPredicate(format: "label CONTAINS[c] %@", addActionButtonIdentifier)
        ).firstMatch
    }
    
    /// Add Item button
    var addItemButton: XCUIElement {
        return app.buttons.containing(
            NSPredicate(format: "label CONTAINS[c] %@", addItemButtonIdentifier)
        ).firstMatch
    }
    
    /// Add Apple Pencil button
    var addApplePencilButton: XCUIElement {
        return app.buttons.containing(
            NSPredicate(format: "label CONTAINS[c] %@", addApplePencilButtonLabel)
        ).firstMatch
    }
    
    /// Add AirTag button
    var addAirTagButton: XCUIElement {
        return app.buttons.containing(
            NSPredicate(format: "label CONTAINS[c] %@", addAirTagButtonLabel)
        ).firstMatch
    }
    
    /// Add Other Item button
    var addOtherItemButton: XCUIElement {
        return app.buttons.containing(
            NSPredicate(format: "label CONTAINS[c] %@", addOtherItemButtonLabel)
        ).firstMatch
    }
    
    /// Other Supported Item text
    var otherSupportedItemText: XCUIElement {
        return app.staticTexts.containing(
            NSPredicate(format: "label CONTAINS[c] %@", otherSupportedItemLabel)
        ).firstMatch
    }
    
    /// Share My Location button
    var shareMyLocationButton: XCUIElement {
        return app.buttons.containing(
            NSPredicate(format: "label CONTAINS[c] %@", shareMyLocationButtonLabel)
        ).firstMatch
    }
    
    // MARK: - Verification
    
    /// Verify the add item menu is displayed
    func verifyAddItemMenuIsDisplayed() {
        XCTAssertTrue(addAirTagButton.waitForExistence(timeout: defaultTimeout) ||
                     addApplePencilButton.waitForExistence(timeout: defaultTimeout) ||
                     addOtherItemButton.waitForExistence(timeout: defaultTimeout),
                     "Add item menu should be displayed")
    }
    
    /// Check if add item menu is displayed
    /// - Returns: True if menu is visible
    func isAddItemMenuDisplayed() -> Bool {
        return addAirTagButton.exists || addApplePencilButton.exists || addOtherItemButton.exists
    }
    
    // MARK: - Actions
    
    /// Tap add action button to open menu
    func tapAddActionButton() {
        XCTAssertTrue(addActionButton.waitForExistence(timeout: defaultTimeout),
                     "Add action button should exist")
        addActionButton.tap()
        wait(1.0)
    }
    
    /// Tap Add Item button
    func tapAddItemButton() {
        XCTAssertTrue(addItemButton.waitForExistence(timeout: defaultTimeout),
                     "Add Item button should exist")
        addItemButton.tap()
        wait(1.0)
    }
    
    /// Tap Add AirTag button
    func tapAddAirTag() {
        XCTAssertTrue(addAirTagButton.waitForExistence(timeout: defaultTimeout),
                     "Add AirTag button should exist")
        addAirTagButton.tap()
        wait(1.0)
    }
    
    /// Tap Add Apple Pencil button
    func tapAddApplePencil() {
        XCTAssertTrue(addApplePencilButton.waitForExistence(timeout: defaultTimeout),
                     "Add Apple Pencil button should exist")
        addApplePencilButton.tap()
        wait(1.0)
    }
    
    /// Tap Add Other Item button
    func tapAddOtherItem() {
        XCTAssertTrue(addOtherItemButton.waitForExistence(timeout: defaultTimeout),
                     "Add Other Item button should exist")
        addOtherItemButton.tap()
        wait(1.0)
    }
    
    /// Tap Share My Location button
    func tapShareMyLocation() {
        XCTAssertTrue(shareMyLocationButton.waitForExistence(timeout: defaultTimeout),
                     "Share My Location button should exist")
        shareMyLocationButton.tap()
        wait(1.0)
    }
    
    /// Start adding AirTag
    func startAddingAirTag() {
        verifyAddItemMenuIsDisplayed()
        tapAddAirTag()
    }
    
    /// Start adding Apple Pencil
    func startAddingApplePencil() {
        verifyAddItemMenuIsDisplayed()
        tapAddApplePencil()
    }
    
    /// Start adding other item
    func startAddingOtherItem() {
        verifyAddItemMenuIsDisplayed()
        tapAddOtherItem()
    }
}

/// Page Object for item pairing flow
class ItemPairingPage: BasePage {
    
    // MARK: - Labels
    
    private let connectItemPairingButtonLabel = "Connect"
    private let continueItemPairingButtonLabel = "Continue"
    private let agreeItemPairingButtonLabel = "Agree"
    private let viewItemInFindMyButtonLabel = "View in Find My app"
    private let doneButtonLabel = "Done"
    private let finishTextLabel = "Finish"
    
    // MARK: - Elements
    
    /// Connect button
    var connectButton: XCUIElement {
        return app.buttons[connectItemPairingButtonLabel].firstMatch
    }
    
    /// Continue button
    var continueButton: XCUIElement {
        return app.buttons[continueItemPairingButtonLabel].firstMatch
    }
    
    /// Agree button
    var agreeButton: XCUIElement {
        return app.buttons[agreeItemPairingButtonLabel].firstMatch
    }
    
    /// View in Find My app button
    var viewInFindMyButton: XCUIElement {
        return app.buttons[viewItemInFindMyButtonLabel].firstMatch
    }
    
    /// Done button
    var doneButton: XCUIElement {
        return app.buttons[doneButtonLabel].firstMatch
    }
    
    /// Finish text
    var finishText: XCUIElement {
        return app.staticTexts[finishTextLabel].firstMatch
    }
    
    // MARK: - Verification
    
    /// Verify pairing page is displayed
    func verifyPairingPageIsDisplayed() {
        XCTAssertTrue(connectButton.waitForExistence(timeout: defaultTimeout) ||
                     continueButton.waitForExistence(timeout: defaultTimeout),
                     "Pairing page should be displayed")
    }
    
    // MARK: - Actions
    
    /// Tap Connect button
    func tapConnect() {
        XCTAssertTrue(connectButton.waitForExistence(timeout: defaultTimeout),
                     "Connect button should exist")
        connectButton.tap()
        wait(2.0)
    }
    
    /// Tap Continue button
    func tapContinue() {
        XCTAssertTrue(continueButton.waitForExistence(timeout: defaultTimeout),
                     "Continue button should exist")
        continueButton.tap()
        wait(1.0)
    }
    
    /// Tap Agree button
    func tapAgree() {
        XCTAssertTrue(agreeButton.waitForExistence(timeout: defaultTimeout),
                     "Agree button should exist")
        agreeButton.tap()
        wait(1.0)
    }
    
    /// Tap View in Find My button
    func tapViewInFindMy() {
        XCTAssertTrue(viewInFindMyButton.waitForExistence(timeout: defaultTimeout),
                     "View in Find My button should exist")
        viewInFindMyButton.tap()
        wait(1.0)
    }
    
    /// Tap Done button
    func tapDone() {
        XCTAssertTrue(doneButton.waitForExistence(timeout: defaultTimeout),
                     "Done button should exist")
        doneButton.tap()
        wait(1.0)
    }
    
    /// Complete pairing flow
    func completePairing() {
        verifyPairingPageIsDisplayed()
        
        if connectButton.exists {
            tapConnect()
        }
        
        if continueButton.waitForExistence(timeout: 5.0) {
            tapContinue()
        }
        
        if agreeButton.waitForExistence(timeout: 5.0) {
            tapAgree()
        }
        
        if doneButton.waitForExistence(timeout: 5.0) {
            tapDone()
        }
    }
}
