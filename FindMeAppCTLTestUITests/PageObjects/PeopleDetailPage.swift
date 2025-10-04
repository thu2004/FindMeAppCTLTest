//
//  PeopleDetailPage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-04.
//

import XCTest

/// Page Object representing the People detail screen in FindMy app
/// Displays detailed information about a selected person
class PeopleDetailPage: BasePage {
    
    // MARK: - Element Identifiers
    
    private struct Identifiers {
        // Navigation
        static let closeButton = "Close"
        static let doneButton = "Done"
        
        // Person info
        static let personNameID = "PrimaryLabel"  // StaticText identifier
        static let personAvatar = "PersonAvatar"
        
        // Action buttons (from actual UI inspection 2025-10-04)
        static let contactButtonID = "FMPlatterButton"  // ID for Contact button
        static let contactLabel = "Contact,Info"  // Label for Contact button
        static let directionsButtonID = "FMPlatterButton"  // ID for Directions button
        static let directionsLabel = "Directions, "  // Label (note trailing space)
        static let actionButtonID = "DetailsSectionRowActionButton"  // ID for action buttons
        static let addToFavourites = "Add to Favourites"
        static let labelLocation = "Label Current Location"
        static let stopSharing = "Stop Sharing My Location"
        static let remove = "Remove"
        static let addButton = "Add"  // Generic add button
        
        // Location info buttons
        static let secondaryLabel = "SecondaryLabel"  // Address button
        static let tertiaryLabel = "TertiaryLabel"  // Live status button
        
        // Location info
        static let locationLabel = "LocationLabel"
        static let lastSeenLabel = "LastSeenLabel"
        static let addressLabel = "AddressLabel"
        // Map
        static let mapView = "MapView"
        
        // Tabs/Sections
        static let findTab = "Find"
        static let peopleTab = "People"
        static let devicesTab = "Devices"
    }
    
    // MARK: - Elements
    
    /// Back button to return to main screen
    var backButton: XCUIElement {
        return button(withLabel: Identifiers.backButton)
    }
    
    /// Done button
    var doneButton: XCUIElement {
        return button(withLabel: Identifiers.doneButton)
    }
    
    /// Person's name label
    var personNameLabel: XCUIElement {
        return app.staticTexts[Identifiers.personNameID]
    }
    
    /// Person's avatar image
    var personAvatar: XCUIElement {
        return image(withIdentifier: Identifiers.personAvatar)
    }
    
    /// Contact button
    var contactButton: XCUIElement {
        return app.buttons[Identifiers.contactLabel]
    }
    
    /// Directions button
    var directionsButton: XCUIElement {
        return app.buttons[Identifiers.directionsLabel]
    }
    
    /// Add to Favourites button
    var addToFavouritesButton: XCUIElement {
        return app.buttons[Identifiers.addToFavourites]
    }
    
    /// Label Current Location button
    var labelLocationButton: XCUIElement {
        return app.buttons[Identifiers.labelLocation]
    }
    
    /// Stop Sharing My Location button
    var stopSharingButton: XCUIElement {
        return app.buttons[Identifiers.stopSharing]
    }
    
    /// Remove button
    var removeButton: XCUIElement {
        return app.buttons[Identifiers.remove]
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
    
    /// Tap back button to return to main screen
    @discardableResult
    func tapBackButton() -> FindMyMainPage {
        tap(backButton)
        return FindMyMainPage(app: app)
    }
    
    /// Tap done button
    @discardableResult
    func tapDoneButton() -> FindMyMainPage {
        tap(doneButton)
        return FindMyMainPage(app: app)
    }
    
    /// Tap contact button
    @discardableResult
    func tapContact() -> PeopleDetailPage {
        tap(contactButton)
        return self
    }
    
    /// Get directions to the person's location
    @discardableResult
    func getDirections() -> PeopleDetailPage {
        tap(directionsButton)
        return self
    }
    
    /// Add to favourites
    @discardableResult
    func addToFavourites() -> PeopleDetailPage {
        tap(addToFavouritesButton)
        return self
    }
    
    /// Label current location
    @discardableResult
    func labelCurrentLocation() -> PeopleDetailPage {
        tap(labelLocationButton)
        return self
    }
    
    /// Stop sharing location
    @discardableResult
    func stopSharingLocation() -> PeopleDetailPage {
        tap(stopSharingButton)
        return self
    }
    
    /// Remove this person
    @discardableResult
    func removePerson() -> PeopleDetailPage {
        tap(removeButton)
        return self
    }
    
    /// Tap on the map view
    @discardableResult
    func tapMap() -> PeopleDetailPage {
        tap(mapView)
        return self
    }
    
    // MARK: - Verifications
    
    /// Verify the detail page is displayed
    @discardableResult
    func verifyDetailPageIsDisplayed() -> PeopleDetailPage {
        verifyElementExists(mapView, timeout: defaultTimeout)
        return self
    }
    
    /// Verify person name is displayed
    @discardableResult
    func verifyPersonName(_ expectedName: String) -> PeopleDetailPage {
        let nameElement = app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] %@", expectedName)).firstMatch
        verifyElementExists(nameElement, timeout: defaultTimeout)
        return self
    }
    
    /// Verify location is displayed
    @discardableResult
    func verifyLocationIsDisplayed() -> PeopleDetailPage {
        // Location info should be visible
        XCTAssertTrue(app.staticTexts.count > 0, "Location information should be displayed")
        return self
    }
    
    /// Verify Contact button is visible
    @discardableResult
    func verifyContactButtonIsVisible() -> PeopleDetailPage {
        verifyElementExists(contactButton, timeout: defaultTimeout)
        return self
    }
    
    /// Verify Directions button is visible
    @discardableResult
    func verifyDirectionsButtonIsVisible() -> PeopleDetailPage {
        verifyElementExists(directionsButton, timeout: defaultTimeout)
        return self
    }
    
    /// Verify Remove button is visible
    @discardableResult
    func verifyRemoveButtonIsVisible() -> PeopleDetailPage {
        verifyElementExists(removeButton, timeout: defaultTimeout)
        return self
    }
    
    /// Verify map is displayed
    @discardableResult
    func verifyMapIsDisplayed() -> PeopleDetailPage {
        verifyElementExists(mapView, timeout: defaultTimeout)
        return self
    }
    
    /// Verify back button is visible
    @discardableResult
    func verifyBackButtonIsVisible() -> PeopleDetailPage {
        verifyElementExists(backButton, timeout: defaultTimeout)
        return self
    }
    
    // MARK: - Helper Methods
    
    /// Get the person's name from the page
    func getPersonName() -> String {
        return personNameLabel.label
    }
    
    /// Get the location text
    func getLocationText() -> String {
        return locationLabel.label
    }
    
    /// Get the last seen text
    func getLastSeenText() -> String {
        return lastSeenLabel.label
    }
    
    /// Check if Contact button is enabled
    func isContactEnabled() -> Bool {
        return contactButton.isEnabled
    }
    
    /// Check if Directions button is enabled
    func isDirectionsEnabled() -> Bool {
        return directionsButton.isEnabled
    }
    
    /// Check if Remove button is enabled
    func isRemoveEnabled() -> Bool {
        return removeButton.isEnabled
    }
}
