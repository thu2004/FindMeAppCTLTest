//
//  FindMyUIInspectionTests.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-04.
//

import XCTest

/// UI Inspection test class for analyzing FindMy app structure
/// This test prints out all UI elements to help update page objects
final class FindMyUIInspectionTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Clean up after inspection
        TestContext.shared.terminateFindMyApp()
    }

    @MainActor
    func testInspectFindMyAppUI() throws {
        // Launch FindMy app
        TestContext.shared.launchFindMyApp()
        let app = TestContext.shared.getFindMyApp()
        
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
        
        print("\n" + String(repeating: "=", count: 80))
        print("FINDMY APP UI INSPECTION - \(timestamp)")
        print(String(repeating: "=", count: 80) + "\n")
        
        // Inspect main page first
        inspectMainPage(app: app)
        
        // Print full app hierarchy
        print("📱 FULL APP HIERARCHY:")
        print(String(repeating: "-", count: 80))
        print(app.debugDescription)
        print("\n")
        
        // Print all buttons
        print("🔘 ALL BUTTONS:")
        print(String(repeating: "-", count: 80))
        let buttons = app.buttons
        print("Total buttons found: \(buttons.count)")
        for (index, button) in buttons.allElementsBoundByIndex.enumerated() {
            if button.exists {
                print("Button \(index):")
                print("  - Label: '\(button.label)'")
                print("  - Identifier: '\(button.identifier)'")
                print("  - Value: '\(button.value ?? "nil")'")
                print("  - isSelected: \(button.isSelected)")
                print("  - isEnabled: \(button.isEnabled)")
                print("")
            }
        }
        
        // Print all tab bars
        print("\n📊 TAB BARS:")
        print(String(repeating: "-", count: 80))
        let tabBars = app.tabBars
        print("Total tab bars found: \(tabBars.count)")
        for (index, tabBar) in tabBars.allElementsBoundByIndex.enumerated() {
            if tabBar.exists {
                print("TabBar \(index):")
                print("  - Label: '\(tabBar.label)'")
                print("  - Identifier: '\(tabBar.identifier)'")
                print("  - Buttons in tab bar: \(tabBar.buttons.count)")
                
                // Print tab bar buttons
                for (btnIndex, tabButton) in tabBar.buttons.allElementsBoundByIndex.enumerated() {
                    if tabButton.exists {
                        print("    Tab Button \(btnIndex):")
                        print("      - Label: '\(tabButton.label)'")
                        print("      - Identifier: '\(tabButton.identifier)'")
                        print("      - isSelected: \(tabButton.isSelected)")
                    }
                }
                print("")
            }
        }
        
        // Print all navigation bars
        print("\n🧭 NAVIGATION BARS:")
        print(String(repeating: "-", count: 80))
        let navBars = app.navigationBars
        print("Total navigation bars found: \(navBars.count)")
        for (index, navBar) in navBars.allElementsBoundByIndex.enumerated() {
            if navBar.exists {
                print("NavigationBar \(index):")
                print("  - Label: '\(navBar.label)'")
                print("  - Identifier: '\(navBar.identifier)'")
                print("")
            }
        }
        
        // Print all static texts
        print("\n📝 STATIC TEXTS (first 20):")
        print(String(repeating: "-", count: 80))
        let staticTexts = app.staticTexts
        print("Total static texts found: \(staticTexts.count)")
        for (index, text) in staticTexts.allElementsBoundByIndex.prefix(20).enumerated() {
            if text.exists {
                print("StaticText \(index):")
                print("  - Label: '\(text.label)'")
                print("  - Identifier: '\(text.identifier)'")
                print("")
            }
        }
        
        // Print all tables
        print("\n📋 TABLES:")
        print(String(repeating: "-", count: 80))
        let tables = app.tables
        print("Total tables found: \(tables.count)")
        for (index, table) in tables.allElementsBoundByIndex.enumerated() {
            if table.exists {
                print("Table \(index):")
                print("  - Label: '\(table.label)'")
                print("  - Identifier: '\(table.identifier)'")
                print("  - Cells: \(table.cells.count)")
                print("")
            }
        }
        
        // Print all collection views
        print("\n🗂️ COLLECTION VIEWS:")
        print(String(repeating: "-", count: 80))
        let collectionViews = app.collectionViews
        print("Total collection views found: \(collectionViews.count)")
        for (index, collectionView) in collectionViews.allElementsBoundByIndex.enumerated() {
            if collectionView.exists {
                print("CollectionView \(index):")
                print("  - Label: '\(collectionView.label)'")
                print("  - Identifier: '\(collectionView.identifier)'")
                print("  - Cells: \(collectionView.cells.count)")
                print("")
            }
        }
        
        // Print all other elements
        print("\n🔍 OTHER ELEMENTS:")
        print(String(repeating: "-", count: 80))
        print("Switches: \(app.switches.count)")
        print("TextFields: \(app.textFields.count)")
        print("TextViews: \(app.textViews.count)")
        print("SearchFields: \(app.searchFields.count)")
        print("SegmentedControls: \(app.segmentedControls.count)")
        print("Sliders: \(app.sliders.count)")
        print("Images: \(app.images.count)")
        print("Icons: \(app.icons.count)")
        print("Maps: \(app.maps.count)")
        print("WebViews: \(app.webViews.count)")
        
        print("\n" + String(repeating: "=", count: 80))
        print("END OF UI INSPECTION")
        print(String(repeating: "=", count: 80) + "\n")
        
        // Take a screenshot for reference
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "FindMy_UI_Inspection"
        attachment.lifetime = .keepAlways
        add(attachment)
        
        // Keep app open for 10 seconds to allow manual inspection
        print("⏱️ Keeping app open for 10 seconds for manual inspection...")
        Thread.sleep(forTimeInterval: 10.0)
    }
    
    // MARK: - Comprehensive Tab and Detail Inspection
    
    @MainActor
    func testInspectAllTabsAndDetails() throws {
        // Launch FindMy app
        TestContext.shared.launchFindMyApp()
        let app = TestContext.shared.getFindMyApp()
        
        print("\n" + String(repeating: "=", count: 80))
        print("COMPREHENSIVE TAB & DETAIL PAGE INSPECTION")
        print(String(repeating: "=", count: 80) + "\n")
        
        // Inspect People Tab and Detail
        print("\n" + String(repeating: "█", count: 80))
        print("PEOPLE TAB INSPECTION")
        print(String(repeating: "█", count: 80))
        inspectPeopleTab(app: app)
        
        // Inspect Devices Tab and Detail
        print("\n" + String(repeating: "█", count: 80))
        print("DEVICES TAB INSPECTION")
        print(String(repeating: "█", count: 80))
        inspectDevicesTab(app: app)
        
        // Inspect Items Tab and Detail
        print("\n" + String(repeating: "█", count: 80))
        print("ITEMS TAB INSPECTION")
        print(String(repeating: "█", count: 80))
        inspectItemsTab(app: app)
        
        // Inspect Me Tab
        print("\n" + String(repeating: "█", count: 80))
        print("ME TAB INSPECTION")
        print(String(repeating: "█", count: 80))
        inspectMeTab(app: app)
        
        print("\n" + String(repeating: "=", count: 80))
        print("END OF COMPREHENSIVE INSPECTION")
        print(String(repeating: "=", count: 80) + "\n")
    }
    
    // MARK: - Helper Methods
    
    private func inspectMainPage(app: XCUIApplication) {
        print("📱 MAIN PAGE:")
        print(String(repeating: "-", count: 80))
        printAllButtons(app: app, context: "Main Page")
        Thread.sleep(forTimeInterval: 2.0)
    }
    
    private func inspectPeopleTab(app: XCUIApplication) {
        // Navigate to People tab
        let peopleButton = app.buttons["People"]
        if peopleButton.exists {
            peopleButton.tap()
            Thread.sleep(forTimeInterval: 2.0)
            
            print("\n👥 PEOPLE TAB - Main View:")
            printAllButtons(app: app, context: "People Tab")
            printAllCells(app: app, context: "People List")
            
            // Take screenshot
            saveScreenshot(app: app, name: "People_Tab")
            
            // Tap first person if exists
            let cells = app.tables.cells
            if cells.count > 0 {
                print("\n👤 Tapping first person...")
                cells.element(boundBy: 0).tap()
                Thread.sleep(forTimeInterval: 3.0)
                
                print("\n📋 PEOPLE DETAIL PAGE:")
                printAllButtons(app: app, context: "People Detail")
                printAllStaticTexts(app: app, context: "People Detail", limit: 20)
                
                // Take screenshot
                saveScreenshot(app: app, name: "People_Detail")
                
                // Go back
                let closeButton = app.buttons["Close"]
                if closeButton.exists {
                    closeButton.tap()
                    Thread.sleep(forTimeInterval: 1.0)
                }
            }
        }
    }
    
    private func inspectDevicesTab(app: XCUIApplication) {
        // Navigate to Devices tab
        let devicesButton = app.buttons["Devices"]
        if devicesButton.exists {
            devicesButton.tap()
            Thread.sleep(forTimeInterval: 2.0)
            
            print("\n📱 DEVICES TAB - Main View:")
            printAllButtons(app: app, context: "Devices Tab")
            printAllCells(app: app, context: "Devices List")
            
            // Take screenshot
            saveScreenshot(app: app, name: "Devices_Tab")
            
            // Tap first device if exists
            let cells = app.tables.cells
            if cells.count > 0 {
                print("\n📲 Tapping first device...")
                cells.element(boundBy: 0).tap()
                Thread.sleep(forTimeInterval: 3.0)
                
                print("\n📋 DEVICE DETAIL PAGE:")
                printAllButtons(app: app, context: "Device Detail")
                printAllStaticTexts(app: app, context: "Device Detail", limit: 20)
                
                // Take screenshot
                saveScreenshot(app: app, name: "Device_Detail")
                
                // Go back
                let closeButton = app.buttons["Close"]
                if closeButton.exists {
                    closeButton.tap()
                    Thread.sleep(forTimeInterval: 1.0)
                }
            }
        }
    }
    
    private func inspectItemsTab(app: XCUIApplication) {
        // Navigate to Items tab
        let itemsButton = app.buttons["Items"]
        if itemsButton.exists {
            itemsButton.tap()
            Thread.sleep(forTimeInterval: 2.0)
            
            print("\n🔍 ITEMS TAB - Main View:")
            printAllButtons(app: app, context: "Items Tab")
            printAllCells(app: app, context: "Items List")
            
            // Take screenshot
            saveScreenshot(app: app, name: "Items_Tab")
            
            // Tap first item if exists
            let cells = app.tables.cells
            if cells.count > 0 {
                print("\n🏷️ Tapping first item...")
                cells.element(boundBy: 0).tap()
                Thread.sleep(forTimeInterval: 3.0)
                
                print("\n📋 ITEM DETAIL PAGE:")
                printAllButtons(app: app, context: "Item Detail")
                printAllStaticTexts(app: app, context: "Item Detail", limit: 20)
                
                // Take screenshot
                saveScreenshot(app: app, name: "Item_Detail")
                
                // Go back
                let closeButton = app.buttons["Close"]
                if closeButton.exists {
                    closeButton.tap()
                    Thread.sleep(forTimeInterval: 1.0)
                }
            }
        }
    }
    
    private func inspectMeTab(app: XCUIApplication) {
        // Navigate to Me tab
        let meButton = app.buttons["Me"]
        if meButton.exists {
            meButton.tap()
            Thread.sleep(forTimeInterval: 2.0)
            
            print("\n👤 ME TAB - Main View:")
            printAllButtons(app: app, context: "Me Tab")
            printAllStaticTexts(app: app, context: "Me Tab", limit: 30)
            
            // Take screenshot
            saveScreenshot(app: app, name: "Me_Tab")
        }
    }
    
    private func printAllButtons(app: XCUIApplication, context: String) {
        print("\n🔘 BUTTONS in \(context):")
        print(String(repeating: "-", count: 60))
        let buttons = app.buttons
        print("Total: \(buttons.count)")
        for (index, button) in buttons.allElementsBoundByIndex.enumerated() {
            if button.exists {
                print("  [\(index)] '\(button.label)' | ID: '\(button.identifier)' | Selected: \(button.isSelected) | Enabled: \(button.isEnabled)")
            }
        }
    }
    
    private func printAllCells(app: XCUIApplication, context: String) {
        print("\n📋 CELLS in \(context):")
        print(String(repeating: "-", count: 60))
        let cells = app.tables.cells
        print("Total: \(cells.count)")
        for (index, cell) in cells.allElementsBoundByIndex.prefix(10).enumerated() {
            if cell.exists {
                print("  [\(index)] '\(cell.label)' | ID: '\(cell.identifier)'")
            }
        }
    }
    
    private func printAllStaticTexts(app: XCUIApplication, context: String, limit: Int = 15) {
        print("\n📝 STATIC TEXTS in \(context):")
        print(String(repeating: "-", count: 60))
        let texts = app.staticTexts
        print("Total: \(texts.count) (showing first \(limit))")
        for (index, text) in texts.allElementsBoundByIndex.prefix(limit).enumerated() {
            if text.exists {
                print("  [\(index)] '\(text.label)' | ID: '\(text.identifier)'")
            }
        }
    }
    
    private func saveScreenshot(app: XCUIApplication, name: String) {
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
