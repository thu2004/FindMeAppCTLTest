//
//  DeviceTests.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-04.
//

import XCTest

/// Test class for device-related functionality in FindMy app
final class DeviceTests: XCTestCase {
    
    // MARK: - Constants
    
    private enum TestConstants {
        static let deviceName = "Chi’s Laptop"
        static let deviceNameKeywordChi = "chi"
        static let deviceNameKeywordLaptop = "laptop"
        
        static let waitTimeShort: TimeInterval = 1.0
        static let waitTimeMedium: TimeInterval = 2.0
        static let waitTimeLong: TimeInterval = 3.0
        static let waitTimePlaySound: TimeInterval = 5.0
    }
    
    // MARK: - Properties
    
    private var app: XCUIApplication!
    private var mainPage: FindMyMainPage!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        TestContext.shared.launchFindMyApp()
        app = TestContext.shared.getFindMyApp()
        mainPage = FindMyMainPage(app: app)
        
        mainPage.verifyMainPageIsDisplayed()
    }

    override func tearDownWithError() throws {
        TestContext.shared.terminateFindMyApp()
    }

    // MARK: - Chi's Laptop Tests
    
    @MainActor
    func testPlaySoundOnChisLaptop() throws {
        mainPage.navigateToDevicesTab()
        
        let deviceDetailPage = mainPage.tapDeviceByName(TestConstants.deviceName)
        
        let deviceName = deviceDetailPage.getDeviceName()
        XCTAssertTrue(deviceName.localizedCaseInsensitiveContains(TestConstants.deviceNameKeywordChi), 
                     "Device name should contain 'Chi'")
        XCTAssertTrue(deviceName.localizedCaseInsensitiveContains(TestConstants.deviceNameKeywordLaptop), 
                     "Device name should contain 'Laptop'")
        
        deviceDetailPage.verifyPlaySoundButtonIsVisible()
        deviceDetailPage.playSound()
        
        mainPage.wait(TestConstants.waitTimePlaySound)
        
        let returnedMainPage = deviceDetailPage.tapCloseButton()
        returnedMainPage.verifyMainPageIsDisplayed()
        mainPage.wait(TestConstants.waitTimeShort)
    }
    
    @MainActor
    func testViewChisLaptopDetails() throws {
        mainPage.navigateToDevicesTab()
        
        let deviceDetailPage = mainPage.tapDeviceByName(TestConstants.deviceName)
        deviceDetailPage.verifyPlaySoundButtonIsVisible()
        deviceDetailPage.verifyDirectionsButtonIsVisible()
        deviceDetailPage.verifyMarkAsLostButtonIsVisible()
        
        deviceDetailPage.tapCloseButton()
        mainPage.wait(TestConstants.waitTimeShort)
    }
    
    @MainActor
    func testChisLaptopDirections() throws {
        mainPage.navigateToDevicesTab()
        
        let deviceDetailPage = mainPage.tapDeviceByName(TestConstants.deviceName)
        deviceDetailPage.verifyDirectionsButtonIsVisible()
        XCTAssertTrue(deviceDetailPage.isDirectionsEnabled(), 
                     "Directions button should be enabled")
        
        deviceDetailPage.getDirections()
        mainPage.wait(TestConstants.waitTimeLong)
    }
    
    @MainActor
    func testChisLaptopLocationInfo() throws {
        mainPage.navigateToDevicesTab()
        
        let deviceDetailPage = mainPage.tapDeviceByName(TestConstants.deviceName)
        
        let locationText = deviceDetailPage.getLocationText()
        let lastSeenText = deviceDetailPage.getLastSeenText()
        
        XCTAssertFalse(locationText.isEmpty, "Location text should not be empty")
        XCTAssertFalse(lastSeenText.isEmpty, "Last seen text should not be empty")
        
        deviceDetailPage.verifyMapIsDisplayed()
        deviceDetailPage.tapCloseButton()
        mainPage.wait(TestConstants.waitTimeShort)
    }
    
    // MARK: - General Device Tests
    
    @MainActor
    func testNavigateToDevicesAndViewFirst() throws {
        mainPage.navigateToDevicesTab()
        
        mainPage.verifyListTableIsDisplayed()
        
        let deviceCount = mainPage.getListItemCount()
        XCTAssertGreaterThan(deviceCount, 0, "Should have at least one device")
        
        let deviceDetailPage = mainPage.tapFirstDevice()
        mainPage.wait(TestConstants.waitTimeLong)
        
        deviceDetailPage.verifyDetailPageIsDisplayed()
        deviceDetailPage.tapCloseButton()
        mainPage.wait(TestConstants.waitTimeShort)
    }
}
