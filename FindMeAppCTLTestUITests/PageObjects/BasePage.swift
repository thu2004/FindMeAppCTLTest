//
//  BasePage.swift
//  FindMeAppCTLTestUITests
//
//  Created by Chi Thu Le on 2025-10-04.
//

import XCTest

/// Base class for all Page Objects following the Page Object design pattern
/// Provides common functionality and utilities for interacting with UI elements
class BasePage {
    
    // MARK: - Properties
    
    /// The application instance being tested
    let app: XCUIApplication
    
    /// Default timeout for element queries
    let defaultTimeout: TimeInterval
    
    // MARK: - Initialization
    
    init(app: XCUIApplication, timeout: TimeInterval = 10.0) {
        self.app = app
        self.defaultTimeout = timeout
    }
    
    // MARK: - Element Query Methods
    
    /// Find an element by accessibility identifier
    func element(withIdentifier identifier: String) -> XCUIElement {
        return app.descendants(matching: .any).matching(identifier: identifier).firstMatch
    }
    
    /// Find a button by identifier
    func button(withIdentifier identifier: String) -> XCUIElement {
        return app.buttons[identifier]
    }
    
    /// Find a button by label
    func button(withLabel label: String) -> XCUIElement {
        return app.buttons[label]
    }
    
    /// Find a static text element
    func staticText(withLabel label: String) -> XCUIElement {
        return app.staticTexts[label]
    }
    
    /// Find an image by identifier
    func image(withIdentifier identifier: String) -> XCUIElement {
        return app.images[identifier]
    }
    
    /// Find a text field by identifier
    func textField(withIdentifier identifier: String) -> XCUIElement {
        return app.textFields[identifier]
    }
    
    /// Find a navigation bar
    func navigationBar(withIdentifier identifier: String) -> XCUIElement {
        return app.navigationBars[identifier]
    }
    
    /// Find a tab bar
    func tabBar() -> XCUIElement {
        return app.tabBars.firstMatch
    }
    
    /// Find a tab button by label
    func tabButton(withLabel label: String) -> XCUIElement {
        return app.tabBars.buttons[label]
    }
    
    // MARK: - Wait Methods
    
    /// Wait for an element to exist
    @discardableResult
    func waitForElement(_ element: XCUIElement, timeout: TimeInterval? = nil) -> Bool {
        let timeoutValue = timeout ?? defaultTimeout
        return element.waitForExistence(timeout: timeoutValue)
    }
    
    /// Wait for an element to exist and be hittable
    @discardableResult
    func waitForElementToBeHittable(_ element: XCUIElement, timeout: TimeInterval? = nil) -> Bool {
        let timeoutValue = timeout ?? defaultTimeout
        let predicate = NSPredicate(format: "exists == true AND isHittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeoutValue)
        return result == .completed
    }
    
    /// Wait for an element to disappear
    @discardableResult
    func waitForElementToDisappear(_ element: XCUIElement, timeout: TimeInterval? = nil) -> Bool {
        let timeoutValue = timeout ?? defaultTimeout
        let predicate = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeoutValue)
        return result == .completed
    }
    
    // MARK: - Action Methods
    
    /// Tap an element with wait
    func tap(_ element: XCUIElement, waitForExistence: Bool = true) {
        if waitForExistence {
            _ = waitForElement(element)
        }
        element.tap()
    }
    
    /// Double tap an element
    func doubleTap(_ element: XCUIElement, waitForExistence: Bool = true) {
        if waitForExistence {
            _ = waitForElement(element)
        }
        element.doubleTap()
    }
    
    /// Long press an element
    func longPress(_ element: XCUIElement, duration: TimeInterval = 1.0, waitForExistence: Bool = true) {
        if waitForExistence {
            _ = waitForElement(element)
        }
        element.press(forDuration: duration)
    }
    
    /// Swipe on an element
    func swipe(_ element: XCUIElement, direction: SwipeDirection, waitForExistence: Bool = true) {
        if waitForExistence {
            _ = waitForElement(element)
        }
        
        switch direction {
        case .up:
            element.swipeUp()
        case .down:
            element.swipeDown()
        case .left:
            element.swipeLeft()
        case .right:
            element.swipeRight()
        }
    }
    
    /// Type text into an element
    func typeText(_ element: XCUIElement, text: String, waitForExistence: Bool = true) {
        if waitForExistence {
            _ = waitForElement(element)
        }
        element.tap()
        element.typeText(text)
    }
    
    /// Clear text from an element
    func clearText(_ element: XCUIElement) {
        guard let stringValue = element.value as? String else {
            return
        }
        
        element.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        element.typeText(deleteString)
    }
    
    // MARK: - Verification Methods
    
    /// Verify element exists
    func verifyElementExists(_ element: XCUIElement, timeout: TimeInterval? = nil, file: StaticString = #file, line: UInt = #line) {
        let exists = waitForElement(element, timeout: timeout)
        XCTAssertTrue(exists, "Element does not exist", file: file, line: line)
    }
    
    /// Verify element does not exist
    func verifyElementDoesNotExist(_ element: XCUIElement, file: StaticString = #file, line: UInt = #line) {
        XCTAssertFalse(element.exists, "Element should not exist", file: file, line: line)
    }
    
    /// Verify element is hittable
    func verifyElementIsHittable(_ element: XCUIElement, timeout: TimeInterval? = nil, file: StaticString = #file, line: UInt = #line) {
        let isHittable = waitForElementToBeHittable(element, timeout: timeout)
        XCTAssertTrue(isHittable, "Element is not hittable", file: file, line: line)
    }
    
    /// Verify element label
    func verifyElementLabel(_ element: XCUIElement, expectedLabel: String, file: StaticString = #file, line: UInt = #line) {
        _ = waitForElement(element)
        XCTAssertEqual(element.label, expectedLabel, "Element label does not match", file: file, line: line)
    }
    
    // MARK: - Screenshot Methods
    
    /// Take a screenshot of the current page
    func takeScreenshot(name: String) -> XCTAttachment {
        let screenshot = XCTAttachment(screenshot: app.screenshot())
        screenshot.name = name
        screenshot.lifetime = .keepAlways
        return screenshot
    }
    
    /// Save screenshot to TestContext
    func saveScreenshot(name: String) {
        let screenshot = takeScreenshot(name: name)
        TestContext.shared.saveScreenshot(name: name, screenshot: screenshot)
    }
    
    // MARK: - Helper Methods
    
    /// Wait for a specified duration
    func wait(_ duration: TimeInterval) {
        Thread.sleep(forTimeInterval: duration)
    }
    
    /// Check if element exists without waiting
    func elementExists(_ element: XCUIElement) -> Bool {
        return element.exists
    }
    
    /// Get element count matching query
    func elementCount(matching query: XCUIElementQuery) -> Int {
        return query.count
    }
}

// MARK: - Supporting Types

/// Swipe direction enumeration
enum SwipeDirection {
    case up
    case down
    case left
    case right
}
