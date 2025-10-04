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
}
