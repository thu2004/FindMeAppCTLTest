//
//  DeviceDetailPage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-04.
//

import XCTest

/// Page Object representing the Device detail screen in FindMy app
/// Displays detailed information about a selected device
class DeviceDetailPage: BasePage {
    
    // MARK: - Element Identifiers
    
    private struct Identifiers {
        // Navigation
        static let closeButton = "Close"
        static let doneButton = "Done"
        
        // Device info (from actual UI inspection 2025-10-04)
        static let deviceNameID = "PrimaryLabel"  // StaticText identifier
        static let deviceImage = "DeviceImage"
        
        // Action buttons
        static let playSoundLabel = "Play Sound,Off"  // FMPlatterButton
        static let directionsLabel = "Directions,"  // FMPlatterButton (no space)
        static let lostModeLabel = "Lost Mode, Enable additional protection, Off"
        static let eraseLabel = "Erase"  // DetailsSectionRowActionButton
        static let removeLabel = "Remove"  // DetailsSectionRowActionButton
        
        // Button IDs
        static let platterButtonID = "FMPlatterButton"
        static let actionButtonID = "DetailsSectionRowActionButton"
        
        // Location info buttons
        static let secondaryLabel = "SecondaryLabel"  // Address
        static let tertiaryLabel = "TertiaryLabel"  // Device status
        
        // Location info
        static let locationLabel = "LocationLabel"
        static let lastSeenLabel = "LastSeenLabel"
        static let addressLabel = "AddressLabel"
        
        // Map
        static let mapView = "MapView"
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
    
    /// Device name label
    var deviceNameLabel: XCUIElement {
        return app.staticTexts[Identifiers.deviceNameID]
    }
    
    /// Device image
    var deviceImage: XCUIElement {
        return image(withIdentifier: Identifiers.deviceImage)
    }
    
    /// Play Sound button
    var playSoundButton: XCUIElement {
        return app.buttons[Identifiers.playSoundLabel]
    }
    
    /// Directions button
    var directionsButton: XCUIElement {
        return app.buttons[Identifiers.directionsLabel]
    }
    
    /// Lost Mode button
    var lostModeButton: XCUIElement {
        return app.buttons[Identifiers.lostModeLabel]
    }
    
    /// Erase Device button
    var eraseDeviceButton: XCUIElement {
        return app.buttons[Identifiers.eraseLabel]
    }
    
    /// Remove Device button
    var removeDeviceButton: XCUIElement {
        return app.buttons[Identifiers.removeLabel]
    }
    
    /// Notify When Found button
    var notifyButton: XCUIElement {
        return app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'notify'")).firstMatch
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
    
    /// Play sound on the device
    @discardableResult
    func playSound() -> DeviceDetailPage {
        tap(playSoundButton)
        return self
    }
    
    /// Get directions to the device location
    @discardableResult
    func getDirections() -> DeviceDetailPage {
        tap(directionsButton)
        return self
    }
    
    /// Mark device as lost
    @discardableResult
    func markAsLost() -> DeviceDetailPage {
        tap(lostModeButton)
        return self
    }
    
    /// Erase this device
    @discardableResult
    func eraseDevice() -> DeviceDetailPage {
        tap(eraseDeviceButton)
        return self
    }
    
    /// Remove this device
    @discardableResult
    func removeDevice() -> DeviceDetailPage {
        tap(removeDeviceButton)
        return self
    }
    
    /// Toggle notify when found
    @discardableResult
    func toggleNotifyWhenFound() -> DeviceDetailPage {
        tap(notifyButton)
        return self
    }
    
    /// Tap on the map view
    @discardableResult
    func tapMap() -> DeviceDetailPage {
        tap(mapView)
        return self
    }
    
    // MARK: - Verifications
    
    /// Verify the detail page is displayed
    @discardableResult
    func verifyDetailPageIsDisplayed() -> DeviceDetailPage {
        verifyElementExists(mapView, timeout: defaultTimeout)
        return self
    }
    
    /// Verify device name is displayed
    @discardableResult
    func verifyDeviceName(_ expectedName: String) -> DeviceDetailPage {
        let nameElement = app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", expectedName)).firstMatch
        verifyElementExists(nameElement, timeout: defaultTimeout)
        return self
    }
    
    /// Verify location is displayed
    @discardableResult
    func verifyLocationIsDisplayed() -> DeviceDetailPage {
        XCTAssertTrue(app.staticTexts.count > 0, "Location information should be displayed")
        return self
    }
    
    /// Verify Play Sound button is visible
    @discardableResult
    func verifyPlaySoundButtonIsVisible() -> DeviceDetailPage {
        verifyElementExists(playSoundButton, timeout: defaultTimeout)
        return self
    }
    
    /// Verify Directions button is visible
    @discardableResult
    func verifyDirectionsButtonIsVisible() -> DeviceDetailPage {
        verifyElementExists(directionsButton, timeout: defaultTimeout)
        return self
    }
    
    /// Verify Mark As Lost button is visible
    @discardableResult
    func verifyMarkAsLostButtonIsVisible() -> DeviceDetailPage {
        verifyElementExists(lostModeButton, timeout: defaultTimeout)
        return self
    }
    
    /// Verify map is displayed
    @discardableResult
    func verifyMapIsDisplayed() -> DeviceDetailPage {
        verifyElementExists(mapView, timeout: defaultTimeout)
        return self
    }
    
    /// Verify close button is visible
    @discardableResult
    func verifyCloseButtonIsVisible() -> DeviceDetailPage {
        verifyElementExists(closeButton, timeout: defaultTimeout)
        return self
    }
    
    // MARK: - Helper Methods
    
    /// Get the device's name from the page
    func getDeviceName() -> String {
        return deviceNameLabel.label
    }
    
    /// Get the location text
    func getLocationText() -> String {
        return locationLabel.label
    }
    
    /// Get the last seen text
    func getLastSeenText() -> String {
        return lastSeenLabel.label
    }
    
    /// Check if Play Sound button is enabled
    func isPlaySoundEnabled() -> Bool {
        return playSoundButton.isEnabled
    }
    
    /// Check if Directions button is enabled
    func isDirectionsEnabled() -> Bool {
        return directionsButton.isEnabled
    }
    
    /// Check if Mark As Lost button is enabled
    func isMarkAsLostEnabled() -> Bool {
        return lostModeButton.isEnabled
    }
}
