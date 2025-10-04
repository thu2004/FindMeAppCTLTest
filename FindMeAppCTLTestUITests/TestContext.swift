//
//  TestContext.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-04.
//

import XCTest

/// Singleton class to manage test-related context data across all UI tests
final class TestContext {
    
    // MARK: - Singleton Instance
    
    static let shared = TestContext()
    
    // MARK: - Properties
    
    /// The FindMy application instance
    private(set) var findMyApp: XCUIApplication?
    
    /// Test configuration settings
    var testConfiguration: [String: Any] = [:]
    
    /// Shared test data
    var testData: [String: Any] = [:]
    
    /// Screenshots captured during tests
    var screenshots: [String: XCTAttachment] = [:]
    
    /// Test execution metadata
    var executionMetadata: [String: Any] = [:]
    
    // MARK: - Initialization
    
    private init() {
        // Private initializer to enforce singleton pattern
        setupDefaultConfiguration()
    }
    
    // MARK: - Configuration
    
    private func setupDefaultConfiguration() {
        testConfiguration["defaultTimeout"] = 10.0
        testConfiguration["launchWaitTime"] = 5.0
        testConfiguration["findMyBundleId"] = "com.apple.findmy"
    }
    
    // MARK: - App Management
    
    /// Initialize and return the FindMy app instance
    func getFindMyApp() -> XCUIApplication {
        if let app = findMyApp {
            return app
        }
        
        let bundleId = testConfiguration["findMyBundleId"] as? String ?? "com.apple.findmy"
        let app = XCUIApplication(bundleIdentifier: bundleId)
        findMyApp = app
        return app
    }
    
    /// Launch the FindMy app with optional launch arguments
    func launchFindMyApp(arguments: [String] = [], environment: [String: String] = [:]) {
        let app = getFindMyApp()
        app.launchArguments = arguments
        app.launchEnvironment = environment
        app.launch()
        
        // Wait for app to stabilize
        if let waitTime = testConfiguration["launchWaitTime"] as? TimeInterval {
            Thread.sleep(forTimeInterval: waitTime)
        }
    }
    
    // MARK: - Screenshot Management
    
    /// Save a screenshot with a given name
    func saveScreenshot(name: String, screenshot: XCTAttachment) {
        screenshots[name] = screenshot
    }
    
    /// Retrieve a saved screenshot by name
    func getScreenshot(name: String) -> XCTAttachment? {
        return screenshots[name]
    }
    
    // MARK: - Test Data Management
    
    /// Store test data with a key
    func setTestData(key: String, value: Any) {
        testData[key] = value
    }
    
    /// Retrieve test data by key
    func getTestData(key: String) -> Any? {
        return testData[key]
    }
    
    /// Clear specific test data
    func clearTestData(key: String) {
        testData.removeValue(forKey: key)
    }
    
    // MARK: - Metadata Management
    
    /// Record execution metadata
    func recordMetadata(key: String, value: Any) {
        executionMetadata[key] = value
    }
    
    /// Get execution metadata
    func getMetadata(key: String) -> Any? {
        return executionMetadata[key]
    }
    
    // MARK: - Cleanup
    
    /// Reset the context (useful between test runs)
    func reset() {
        findMyApp = nil
        testData.removeAll()
        screenshots.removeAll()
        executionMetadata.removeAll()
        setupDefaultConfiguration()
    }
    
    /// Terminate the FindMy app if running
    func terminateFindMyApp() {
        findMyApp?.terminate()
        findMyApp = nil
    }
}
