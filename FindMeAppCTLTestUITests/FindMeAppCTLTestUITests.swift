//
//  FindMeAppCTLTestUITests.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-04.
//

import XCTest

final class FindMeAppCTLTestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        // Using TestContext singleton to manage app instance
        TestContext.shared.launchFindMyApp()
        let app = TestContext.shared.getFindMyApp()

        // Use Page Object pattern for clean, maintainable tests
        let mainPage = FindMyMainPage(app: app)
        mainPage.verifyMainPageIsDisplayed()
        
        // Example: Navigate through tabs
        mainPage.navigateToDevicesTab()
        mainPage.verifyDevicesTabIsSelected()
    }
    
    @MainActor
    func testNavigateThroughAllTabs() throws {
        // Launch FindMy app
        TestContext.shared.launchFindMyApp()
        let app = TestContext.shared.getFindMyApp()
        
        // Create main page object
        let mainPage = FindMyMainPage(app: app)
        
        // Verify main page is displayed
        mainPage.verifyMainPageIsDisplayed()
        
        // Verify all tabs are visible
        mainPage.verifyAllTabsAreVisible()
        
        // Navigate to People tab first (don't assume it's selected)
        print("👥 Testing People tab...")
        mainPage.navigateToPeopleTab()
        mainPage.verifyPeopleTabIsSelected()
        mainPage.wait(5.0)
        mainPage.saveScreenshot(name: "people_tab")
        
        // Test Devices tab
        print("📱 Testing Devices tab...")
        mainPage.navigateToDevicesTab()
        mainPage.verifyDevicesTabIsSelected()
        mainPage.wait(5.0)
        mainPage.saveScreenshot(name: "devices_tab")
        
        // Test Items tab
        print("🔍 Testing Items tab...")
        mainPage.navigateToItemsTab()
        mainPage.verifyItemsTabIsSelected()
        mainPage.wait(5.0)
        mainPage.saveScreenshot(name: "items_tab")
        
        // Test Me tab
        print("👤 Testing Me tab...")
        mainPage.navigateToMeTab()
        mainPage.verifyMeTabIsSelected()
        mainPage.wait(5.0)
        mainPage.saveScreenshot(name: "me_tab")
        
        // Navigate back to People tab to complete the cycle
        print("🔄 Returning to People tab...")
        mainPage.navigateToPeopleTab()
        mainPage.verifyPeopleTabIsSelected()
        mainPage.wait(5.0)
        
        print("✅ All tabs navigation test completed successfully")
    }
    
    @MainActor
    func testTabNavigationSequence() throws {
        // Launch FindMy app
        TestContext.shared.launchFindMyApp()
        let app = TestContext.shared.getFindMyApp()
        
        let mainPage = FindMyMainPage(app: app)
        
        // Test using method chaining
        mainPage
            .verifyMainPageIsDisplayed()
            .navigateToDevicesTab()
        mainPage.verifyDevicesTabIsSelected()
        mainPage.wait(5.0)
        
        mainPage.navigateToItemsTab()
        mainPage.verifyItemsTabIsSelected()
        mainPage.wait(5.0)
        
        mainPage.navigateToMeTab()
        mainPage.verifyMeTabIsSelected()
        mainPage.wait(5.0)
    }
    
    @MainActor
    func testIndividualTabDevices() throws {
        // Test Devices tab specifically
        TestContext.shared.launchFindMyApp()
        let app = TestContext.shared.getFindMyApp()
        
        let mainPage = FindMyMainPage(app: app)
        mainPage.verifyMainPageIsDisplayed()
        
        // Navigate to and verify Devices tab
        mainPage.navigateToDevicesTab()
        mainPage.verifyDevicesTabIsSelected()
        mainPage.wait(5.0)
        
        // Verify tab button is hittable
        mainPage.verifyElementIsHittable(mainPage.devicesTabButton)
        
        print("✅ Devices tab test passed")
    }
    
    @MainActor
    func testIndividualTabItems() throws {
        // Test Items tab specifically
        TestContext.shared.launchFindMyApp()
        let app = TestContext.shared.getFindMyApp()
        
        let mainPage = FindMyMainPage(app: app)
        mainPage.verifyMainPageIsDisplayed()
        
        // Navigate to and verify Items tab
        mainPage.navigateToItemsTab()
        mainPage.verifyItemsTabIsSelected()
        mainPage.wait(5.0)
        
        // Verify tab button is hittable
        mainPage.verifyElementIsHittable(mainPage.itemsTabButton)
        
        print("✅ Items tab test passed")
    }
    
    @MainActor
    func testIndividualTabMe() throws {
        // Test Me tab specifically
        TestContext.shared.launchFindMyApp()
        let app = TestContext.shared.getFindMyApp()
        
        let mainPage = FindMyMainPage(app: app)
        mainPage.verifyMainPageIsDisplayed()
        
        // Navigate to and verify Me tab
        mainPage.navigateToMeTab()
        mainPage.verifyMeTabIsSelected()
        mainPage.wait(5.0)
        
        // Verify tab button is hittable
        mainPage.verifyElementIsHittable(mainPage.meTabButton)
        
        print("✅ Me tab test passed")
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testNavigateToPeopleDetail() throws {
        // Launch FindMy app
        TestContext.shared.launchFindMyApp()
        let app = TestContext.shared.getFindMyApp()
        
        // Create main page object
        let mainPage = FindMyMainPage(app: app)
        
        // Navigate to People tab
        mainPage.verifyMainPageIsDisplayed()
        mainPage.navigateToPeopleTab()
        mainPage.wait(2.0)
        
        // Tap on first person in the list
        print("📱 Tapping on first person...")
        let detailPage = mainPage.tapFirstPerson()
        
        // Verify detail page is displayed
        detailPage.verifyDetailPageIsDisplayed()
        detailPage.verifyMapIsDisplayed()
        detailPage.wait(5.0)
        detailPage.saveScreenshot(name: "people_detail_page")
        
        // Navigate back
        print("⬅️ Navigating back to main page...")
        let returnedMainPage = detailPage.tapBackButton()
        returnedMainPage.verifyMainPageIsDisplayed()
        
        print("✅ People detail navigation test passed")
    }
}
