//
//  FindMyMainPage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-04.
//

import XCTest

/// Page Object representing the main screen of the FindMy app
/// Provides methods to interact with the main navigation and tabs
class FindMyMainPage: BasePage {
    
    // MARK: - Element Identifiers
    
    private struct Identifiers {
        // Tab bar buttons (using labels - app doesn't use accessibility identifiers for tabs)
        // Note: These are localized strings (English)
        static let peopleTab = "People"    // People/Devices with people
        static let devicesTab = "Devices"  // Devices
        static let itemsTab = "Items"      // Items
        static let meTab = "Me"            // Me
        
        // List view
        static let listViewTitle = "FindMyListViewTitle"
        static let addButton = "FindMyListViewAddAction"
        static let cardContainer = "CardContainerView"
        static let listEntries = "FindMyListEntries"
        
        // Cell identifiers
        static let homeCell = "HomeElementCell"
        static let cellTitle = "HomeCellTitleLabel"
        static let cellSubtitle = "HomeCellSubtitleLabel"
    }
    
    // MARK: - Elements
    
    /// Bottom tab bar buttons (FindMy uses custom buttons, not standard tab bar)
    var peopleTabButton: XCUIElement {
        return button(withLabel: Identifiers.peopleTab)
    }
    
    /// Devices tab button
    var devicesTabButton: XCUIElement {
        return button(withLabel: Identifiers.devicesTab)
    }
    
    /// Items tab button
    var itemsTabButton: XCUIElement {
        return button(withLabel: Identifiers.itemsTab)
    }
    
    /// Me tab button
    var meTabButton: XCUIElement {
        return button(withLabel: Identifiers.meTab)
    }
    
    /// Add button
    var addButton: XCUIElement {
        return button(withIdentifier: Identifiers.addButton)
    }
    
    /// Card container (main content area)
    var cardContainer: XCUIElement {
        return element(withIdentifier: Identifiers.cardContainer)
    }
    
    /// List entries container
    var listEntries: XCUIElement {
        return element(withIdentifier: Identifiers.listEntries)
    }
    
    /// List view title
    var listViewTitle: XCUIElement {
        return staticText(withLabel: Identifiers.listViewTitle)
    }
    
    /// Table containing the list items
    var listTable: XCUIElement {
        return app.tables.firstMatch
    }
    
    // MARK: - Actions
    
    /// Navigate to People tab
    @discardableResult
    func navigateToPeopleTab() -> FindMyMainPage {
        tap(peopleTabButton)
        return self
    }
    
    /// Navigate to Devices tab
    @discardableResult
    func navigateToDevicesTab() -> FindMyMainPage {
        tap(devicesTabButton)
        verifyDevicesTabIsSelected()
        wait(2.0)
        return self
    }
    
    /// Navigate to Items tab
    @discardableResult
    func navigateToItemsTab() -> FindMyMainPage {
        tap(itemsTabButton)
        return self
    }
    
    /// Navigate to Me tab
    @discardableResult
    func navigateToMeTab() -> FindMyMainPage {
        tap(meTabButton)
        return self
    }
    
    /// Tap the add button
    @discardableResult
    func tapAddButton() -> FindMyMainPage {
        tap(addButton)
        return self
    }
    
    // MARK: - Verifications
    
    /// Verify the main page is displayed
    @discardableResult
    func verifyMainPageIsDisplayed() -> FindMyMainPage {
        verifyElementExists(cardContainer, timeout: defaultTimeout)
        return self
    }
    
    /// Verify People tab is selected
    @discardableResult
    func verifyPeopleTabIsSelected() -> FindMyMainPage {
        XCTAssertTrue(peopleTabButton.isSelected, "People tab should be selected")
        return self
    }
    
    /// Verify Devices tab is selected
    @discardableResult
    func verifyDevicesTabIsSelected() -> FindMyMainPage {
        XCTAssertTrue(devicesTabButton.isSelected, "Devices tab should be selected")
        return self
    }
    
    /// Verify Items tab is selected
    @discardableResult
    func verifyItemsTabIsSelected() -> FindMyMainPage {
        XCTAssertTrue(itemsTabButton.isSelected, "Items tab should be selected")
        return self
    }
    
    /// Verify Me tab is selected
    @discardableResult
    func verifyMeTabIsSelected() -> FindMyMainPage {
        XCTAssertTrue(meTabButton.isSelected, "Me tab should be selected")
        return self
    }
    
    /// Verify all tabs are visible
    @discardableResult
    func verifyAllTabsAreVisible() -> FindMyMainPage {
        verifyElementExists(peopleTabButton)
        verifyElementExists(devicesTabButton)
        verifyElementExists(itemsTabButton)
        verifyElementExists(meTabButton)
        return self
    }
    
    /// Verify list table is displayed
    @discardableResult
    func verifyListTableIsDisplayed() -> FindMyMainPage {
        verifyElementExists(listTable, timeout: defaultTimeout)
        return self
    }
    
    /// Get number of items in the list
    func getListItemCount() -> Int {
        return listTable.cells.count
    }
    
    // MARK: - Navigation to Detail Pages
    
    // MARK: People Detail Navigation
    
    /// Tap on a person in the list by index
    @discardableResult
    func tapPersonAtIndex(_ index: Int) -> PeopleDetailPage {
        let cell = listTable.cells.element(boundBy: index)
        tap(cell)
        return PeopleDetailPage(app: app)
    }
    
    /// Tap on the first person in the list
    @discardableResult
    func tapFirstPerson() -> PeopleDetailPage {
        return tapPersonAtIndex(0)
    }
    
    // MARK: Device Detail Navigation
    
    /// Tap on a device in the list by index
    @discardableResult
    func tapDeviceAtIndex(_ index: Int) -> DeviceDetailPage {
        let cell = listTable.cells.element(boundBy: index)
        tap(cell)
        return DeviceDetailPage(app: app)
    }
    
    /// Tap on the first device in the list
    @discardableResult
    func tapFirstDevice() -> DeviceDetailPage {
        return tapDeviceAtIndex(0)
    }
    
    // MARK: Item Detail Navigation
    
    /// Tap on an item in the list by index
    @discardableResult
    func tapItemAtIndex(_ index: Int) -> ItemDetailPage {
        let cell = listTable.cells.element(boundBy: index)
        tap(cell)
        return ItemDetailPage(app: app)
    }
    
    /// Tap on the first item in the list
    @discardableResult
    func tapFirstItem() -> ItemDetailPage {
        return tapItemAtIndex(0)
    }
    
    // MARK: - Search by Name Methods
    
    /// Find and tap a device by name (case-insensitive partial match)
    @discardableResult
    func tapDeviceByName(_ deviceName: String) -> DeviceDetailPage {
        let cells = listTable.cells
        for i in 0..<cells.count {
            let cell = cells.element(boundBy: i)
            
            // Check cell label first
            if cell.label.localizedCaseInsensitiveContains(deviceName) {
                tap(cell)
                wait(3.0)
                let detailPage = DeviceDetailPage(app: app)
                detailPage.verifyDetailPageIsDisplayed()
                return detailPage
            }
            
            // Check StaticText elements within the cell
            let staticTexts = cell.staticTexts
            for j in 0..<staticTexts.count {
                let text = staticTexts.element(boundBy: j)
                if text.label.localizedCaseInsensitiveContains(deviceName) {
                    tap(cell)
                    wait(3.0)
                    let detailPage = DeviceDetailPage(app: app)
                    detailPage.verifyDetailPageIsDisplayed()
                    return detailPage
                }
            }
        }
        XCTFail("Device '\(deviceName)' not found in the list")
        return DeviceDetailPage(app: app)
    }
    
    /// Find and tap a person by name (case-insensitive partial match)
    @discardableResult
    func tapPersonByName(_ personName: String) -> PeopleDetailPage {
        let cells = listTable.cells
        for i in 0..<cells.count {
            let cell = cells.element(boundBy: i)
            
            // Check cell label first
            if cell.label.localizedCaseInsensitiveContains(personName) {
                tap(cell)
                return PeopleDetailPage(app: app)
            }
            
            // Check StaticText elements within the cell
            let staticTexts = cell.staticTexts
            for j in 0..<staticTexts.count {
                let text = staticTexts.element(boundBy: j)
                if text.label.localizedCaseInsensitiveContains(personName) {
                    tap(cell)
                    return PeopleDetailPage(app: app)
                }
            }
        }
        XCTFail("Person '\(personName)' not found in the list")
        return PeopleDetailPage(app: app)
    }
    
    /// Find and tap an item by name (case-insensitive partial match)
    @discardableResult
    func tapItemByName(_ itemName: String) -> ItemDetailPage {
        let cells = listTable.cells
        for i in 0..<cells.count {
            let cell = cells.element(boundBy: i)
            
            // Check cell label first
            if cell.label.localizedCaseInsensitiveContains(itemName) {
                tap(cell)
                return ItemDetailPage(app: app)
            }
            
            // Check StaticText elements within the cell
            let staticTexts = cell.staticTexts
            for j in 0..<staticTexts.count {
                let text = staticTexts.element(boundBy: j)
                if text.label.localizedCaseInsensitiveContains(itemName) {
                    tap(cell)
                    return ItemDetailPage(app: app)
                }
            }
        }
        XCTFail("Item '\(itemName)' not found in the list")
        return ItemDetailPage(app: app)
    }
}
