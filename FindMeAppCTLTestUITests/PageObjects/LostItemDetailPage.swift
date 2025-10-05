//
//  LostItemDetailPage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-05.
//

import XCTest

/// Page Object for lost item detail view in FindMy app
/// Handles viewing details of items found by others
class LostItemDetailPage: BasePage {
    
    // MARK: - Identifiers
    
    private let containerViewIdentifier = "CardContainerView"
    private let itemTypeIdentifier = "PrimaryLabel"
    private let locationIdentifier = "SecondaryLabel"
    private let locationAgeIdentifier = "TertiaryLabel"
    private let playSoundButtonIdentifier = "PlaySoundButton"
    private let findButtonIdentifier = "FMPlatterButton"
    
    // MARK: - Labels
    
    private let closeViewButtonLabel = "Close"
    private let noLocationFoundLabel = "No location found"
    private let playSoundButtonActiveLabel = "Sound Playing"
    private let ownerDetailsSectionLabel = "Details"
    private let ownerInfoLabel = "Owner"
    private let itemSerialNumberLabel = "Serial Number"
    
    // MARK: - Elements
    
    /// Base element for lost item detail view
    var baseElement: XCUIElement {
        return app.otherElements[containerViewIdentifier].firstMatch
    }
    
    /// Item type label (e.g., "AirTag", "AirPods")
    var itemTypeLabel: XCUIElement {
        return baseElement.staticTexts[itemTypeIdentifier].firstMatch
    }
    
    /// Location button
    var locationButton: XCUIElement {
        return baseElement.buttons[locationIdentifier].firstMatch
    }
    
    /// No location found button
    var noLocationFoundButton: XCUIElement {
        return baseElement.buttons.containing(
            NSPredicate(format: "label CONTAINS[c] %@", noLocationFoundLabel)
        ).firstMatch
    }
    
    /// Location age button (e.g., "Now", "5 minutes ago")
    var locationAgeButton: XCUIElement {
        return baseElement.buttons[locationAgeIdentifier].firstMatch
    }
    
    /// Close button
    var closeButton: XCUIElement {
        return baseElement.buttons.containing(
            NSPredicate(format: "label CONTAINS[c] %@", closeViewButtonLabel)
        ).firstMatch
    }
    
    /// Play Sound button
    var playSoundButton: XCUIElement {
        return baseElement.buttons[playSoundButtonIdentifier].firstMatch
    }
    
    /// Play Sound button (active state)
    var playSoundButtonActive: XCUIElement {
        return baseElement.buttons.containing(
            NSPredicate(format: "label CONTAINS[c] %@", playSoundButtonActiveLabel)
        ).firstMatch
    }
    
    /// Find button
    var findButton: XCUIElement {
        return baseElement.buttons[findButtonIdentifier].firstMatch
    }
    
    /// Owner details section
    var ownerDetailsSection: XCUIElement {
        return baseElement.staticTexts.containing(
            NSPredicate(format: "label CONTAINS[c] %@", ownerDetailsSectionLabel)
        ).firstMatch
    }
    
    /// Owner info label
    var ownerInfo: XCUIElement {
        return baseElement.staticTexts.containing(
            NSPredicate(format: "label CONTAINS[c] %@", ownerInfoLabel)
        ).firstMatch
    }
    
    /// Item serial number label
    var itemSerialNumber: XCUIElement {
        return baseElement.staticTexts.containing(
            NSPredicate(format: "label CONTAINS[c] %@", itemSerialNumberLabel)
        ).firstMatch
    }
    
    // MARK: - Verification
    
    /// Verify the lost item detail page is displayed
    func verifyLostItemDetailPageIsDisplayed() {
        XCTAssertTrue(ownerDetailsSection.waitForExistence(timeout: defaultTimeout),
                     "Lost item detail page should be displayed")
    }
    
    /// Check if lost item detail page is displayed
    /// - Returns: True if page is visible
    func isLostItemDetailPageDisplayed() -> Bool {
        return ownerDetailsSection.exists
    }
    
    /// Verify item type
    /// - Parameter type: Expected item type
    func verifyItemType(_ type: String) {
        XCTAssertTrue(itemTypeLabel.exists, "Item type label should exist")
        XCTAssertTrue(itemTypeLabel.label.contains(type),
                     "Item type should contain '\(type)'")
    }
    
    /// Verify location is displayed
    func verifyLocationIsDisplayed() {
        XCTAssertTrue(locationButton.exists || noLocationFoundButton.exists,
                     "Location or no location message should be displayed")
    }
    
    // MARK: - Actions
    
    /// Tap close button
    func tapCloseButton() {
        XCTAssertTrue(closeButton.waitForExistence(timeout: defaultTimeout),
                     "Close button should exist")
        closeButton.tap()
        wait(1.0)
    }
    
    /// Tap play sound button
    func tapPlaySound() {
        XCTAssertTrue(playSoundButton.waitForExistence(timeout: defaultTimeout),
                     "Play Sound button should exist")
        playSoundButton.tap()
        wait(1.0)
    }
    
    /// Stop playing sound
    func stopPlayingSound() {
        if playSoundButtonActive.waitForExistence(timeout: 2.0) {
            playSoundButtonActive.tap()
            wait(1.0)
        }
    }
    
    /// Tap find button
    func tapFind() {
        XCTAssertTrue(findButton.waitForExistence(timeout: defaultTimeout),
                     "Find button should exist")
        findButton.tap()
        wait(1.0)
    }
    
    /// Tap location button
    func tapLocation() {
        XCTAssertTrue(locationButton.waitForExistence(timeout: defaultTimeout),
                     "Location button should exist")
        locationButton.tap()
        wait(1.0)
    }
    
    // MARK: - Information Retrieval
    
    /// Get item type
    /// - Returns: Item type string
    func getItemType() -> String {
        return itemTypeLabel.label
    }
    
    /// Get location text
    /// - Returns: Location string
    func getLocation() -> String {
        if locationButton.exists {
            return locationButton.label
        } else if noLocationFoundButton.exists {
            return noLocationFoundButton.label
        }
        return ""
    }
    
    /// Get location age
    /// - Returns: Location age string (e.g., "Now", "5 minutes ago")
    func getLocationAge() -> String {
        return locationAgeButton.label
    }
    
    /// Check if sound is playing
    /// - Returns: True if sound is currently playing
    func isSoundPlaying() -> Bool {
        return playSoundButtonActive.exists
    }
    
    /// Check if location is available
    /// - Returns: True if location is available
    func hasLocation() -> Bool {
        return locationButton.exists && !noLocationFoundButton.exists
    }
}
