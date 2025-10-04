//
//  ItemDetailPage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-04.
//

import XCTest

/// Page Object representing the Item detail screen in FindMy app
/// Displays detailed information about a selected AirTag or item
class ItemDetailPage: BasePage {
    
    // MARK: - Element Identifiers
    
    private struct Identifiers {
        // Navigation
        static let closeButton = "Close"
        static let doneButton = "Done"
        
        // Item info
        static let itemName = "ItemName"
        static let itemImage = "ItemImage"
        
        // Action buttons
        static let playSound = "Play Sound"
        static let directions = "Directions, "
        static let findNearby = "Find Nearby"
        static let lostMode = "Lost Mode"
        static let removeItem = "Remove Item"
        static let notify = "Notify When Found"
        static let identify = "Identify Found Item"
        
        // Location info
        static let locationLabel = "LocationLabel"
        static let lastSeenLabel = "LastSeenLabel"
        static let addressLabel = "AddressLabel"
        
        // Map
        static let mapView = "MapView"
        
        // Battery
        static let batteryLabel = "BatteryLabel"
    }
    
    // MARK: - Elements
    
    /// Close button to return to main screen
    var closeButton: XCUIElement {
        return button(withLabel: Identifiers.closeButton)
    }
    
    /// Done button
    var doneButton: XCUIElement {
        return button(withLabel: Identifiers.doneButton)
    }
    
    /// Item name label
    var itemNameLabel: XCUIElement {
        return staticText(withLabel: Identifiers.itemName)
    }
    
    /// Item image
    var itemImage: XCUIElement {
        return image(withIdentifier: Identifiers.itemImage)
    }
    
    /// Play Sound button
    var playSoundButton: XCUIElement {
        return button(withLabel: Identifiers.playSound)
    }
    
    /// Directions button
    var directionsButton: XCUIElement {
        return button(withLabel: Identifiers.directions)
    }
    
    /// Find Nearby button (for Precision Finding)
    var findNearbyButton: XCUIElement {
        return button(withLabel: Identifiers.findNearby)
    }
    
    /// Lost Mode button
    var lostModeButton: XCUIElement {
        return button(withLabel: Identifiers.lostMode)
    }
    
    /// Remove Item button
    var removeItemButton: XCUIElement {
        return button(withLabel: Identifiers.removeItem)
    }
    
    /// Notify When Found button
    var notifyButton: XCUIElement {
        return button(withLabel: Identifiers.notify)
    }
    
    /// Identify Found Item button
    var identifyButton: XCUIElement {
        return button(withLabel: Identifiers.identify)
    }
    
    /// Location label
    var locationLabel: XCUIElement {
        return staticText(withLabel: Identifiers.locationLabel)
    }
    
    /// Last seen time label
    var lastSeenLabel: XCUIElement {
        return staticText(withLabel: Identifiers.lastSeenLabel)
    }
    
    /// Address label
    var addressLabel: XCUIElement {
        return staticText(withLabel: Identifiers.addressLabel)
    }
    
    /// Battery label
    var batteryLabel: XCUIElement {
        return staticText(withLabel: Identifiers.batteryLabel)
    }
    
    /// Map view
    var mapView: XCUIElement {
        return app.maps.firstMatch
    }
    
    // MARK: - Actions
    
    /// Tap close button to return to main screen
    @discardableResult
    func tapCloseButton() -> FindMyMainPage {
        tap(closeButton)
        return FindMyMainPage(app: app)
    }
    
    /// Tap done button
    @discardableResult
    func tapDoneButton() -> FindMyMainPage {
        tap(doneButton)
        return FindMyMainPage(app: app)
    }
    
    /// Play sound on the item
    @discardableResult
    func playSound() -> ItemDetailPage {
        tap(playSoundButton)
        return self
    }
    
    /// Get directions to the item location
    @discardableResult
    func getDirections() -> ItemDetailPage {
        tap(directionsButton)
        return self
    }
    
    /// Start Find Nearby (Precision Finding)
    @discardableResult
    func findNearby() -> ItemDetailPage {
        tap(findNearbyButton)
        return self
    }
    
    /// Enable/disable Lost Mode
    @discardableResult
    func toggleLostMode() -> ItemDetailPage {
        tap(lostModeButton)
        return self
    }
    
    /// Remove this item
    @discardableResult
    func removeItem() -> ItemDetailPage {
        tap(removeItemButton)
        return self
    }
    
    /// Toggle notify when found
    @discardableResult
    func toggleNotifyWhenFound() -> ItemDetailPage {
        tap(notifyButton)
        return self
    }
    
    /// Identify found item
    @discardableResult
    func identifyFoundItem() -> ItemDetailPage {
        tap(identifyButton)
        return self
    }
    
    /// Tap on the map view
    @discardableResult
    func tapMap() -> ItemDetailPage {
        tap(mapView)
        return self
    }
    
    // MARK: - Verifications
    
    /// Verify the detail page is displayed
    @discardableResult
    func verifyDetailPageIsDisplayed() -> ItemDetailPage {
        verifyElementExists(mapView, timeout: defaultTimeout)
        return self
    }
    
    /// Verify item name is displayed
    @discardableResult
    func verifyItemName(_ expectedName: String) -> ItemDetailPage {
        let nameElement = app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", expectedName)).firstMatch
        verifyElementExists(nameElement, timeout: defaultTimeout)
        return self
    }
    
    /// Verify location is displayed
    @discardableResult
    func verifyLocationIsDisplayed() -> ItemDetailPage {
        XCTAssertTrue(app.staticTexts.count > 0, "Location information should be displayed")
        return self
    }
    
    /// Verify Play Sound button is visible
    @discardableResult
    func verifyPlaySoundButtonIsVisible() -> ItemDetailPage {
        verifyElementExists(playSoundButton, timeout: defaultTimeout)
        return self
    }
    
    /// Verify Find Nearby button is visible
    @discardableResult
    func verifyFindNearbyButtonIsVisible() -> ItemDetailPage {
        verifyElementExists(findNearbyButton, timeout: defaultTimeout)
        return self
    }
    
    /// Verify Directions button is visible
    @discardableResult
    func verifyDirectionsButtonIsVisible() -> ItemDetailPage {
        verifyElementExists(directionsButton, timeout: defaultTimeout)
        return self
    }
    
    /// Verify Lost Mode button is visible
    @discardableResult
    func verifyLostModeButtonIsVisible() -> ItemDetailPage {
        verifyElementExists(lostModeButton, timeout: defaultTimeout)
        return self
    }
    
    /// Verify map is displayed
    @discardableResult
    func verifyMapIsDisplayed() -> ItemDetailPage {
        verifyElementExists(mapView, timeout: defaultTimeout)
        return self
    }
    
    /// Verify close button is visible
    @discardableResult
    func verifyCloseButtonIsVisible() -> ItemDetailPage {
        verifyElementExists(closeButton, timeout: defaultTimeout)
        return self
    }
    
    // MARK: - Helper Methods
    
    /// Get the item's name from the page
    func getItemName() -> String {
        return itemNameLabel.label
    }
    
    /// Get the location text
    func getLocationText() -> String {
        return locationLabel.label
    }
    
    /// Get the last seen text
    func getLastSeenText() -> String {
        return lastSeenLabel.label
    }
    
    /// Get the battery level text
    func getBatteryLevel() -> String {
        return batteryLabel.label
    }
    
    /// Check if Play Sound button is enabled
    func isPlaySoundEnabled() -> Bool {
        return playSoundButton.isEnabled
    }
    
    /// Check if Find Nearby button is enabled
    func isFindNearbyEnabled() -> Bool {
        return findNearbyButton.isEnabled
    }
    
    /// Check if Directions button is enabled
    func isDirectionsEnabled() -> Bool {
        return directionsButton.isEnabled
    }
    
    /// Check if Lost Mode is enabled
    func isLostModeEnabled() -> Bool {
        return lostModeButton.isEnabled
    }
}
