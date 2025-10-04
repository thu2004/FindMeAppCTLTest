# Page Object Design Pattern

## Overview
This folder contains Page Object classes that represent screens/pages in the FindMy app. The Page Object pattern encapsulates UI elements and interactions, making tests more maintainable and readable.

## Structure

```
PageObjects/
├── BasePage.swift           # Base class with common functionality
├── FindMyMainPage.swift     # Example: Main screen page object
└── README.md               # This file
```

## Design Pattern Benefits

1. **Separation of Concerns**: UI element queries and actions are separated from test logic
2. **Reusability**: Page objects can be reused across multiple tests
3. **Maintainability**: UI changes only require updates in page objects, not in tests
4. **Readability**: Tests read like user scenarios rather than technical implementations
5. **Type Safety**: Swift's type system ensures compile-time safety

## BasePage Class

The `BasePage` class provides common functionality for all page objects:

### Element Query Methods
- `element(withIdentifier:)` - Find any element by accessibility identifier
- `button(withIdentifier:)` / `button(withLabel:)` - Find buttons
- `staticText(withLabel:)` - Find text elements
- `textField(withIdentifier:)` - Find text fields
- `navigationBar(withIdentifier:)` - Find navigation bars
- `tabBar()` / `tabButton(withLabel:)` - Find tab bars and buttons

### Wait Methods
- `waitForElement(_:timeout:)` - Wait for element to exist
- `waitForElementToBeHittable(_:timeout:)` - Wait for element to be interactable
- `waitForElementToDisappear(_:timeout:)` - Wait for element to disappear

### Action Methods
- `tap(_:waitForExistence:)` - Tap an element
- `doubleTap(_:waitForExistence:)` - Double tap an element
- `longPress(_:duration:waitForExistence:)` - Long press an element
- `swipe(_:direction:waitForExistence:)` - Swipe in a direction
- `typeText(_:text:waitForExistence:)` - Type text into element
- `clearText(_:)` - Clear text from element

### Verification Methods
- `verifyElementExists(_:timeout:)` - Assert element exists
- `verifyElementDoesNotExist(_:)` - Assert element doesn't exist
- `verifyElementIsHittable(_:timeout:)` - Assert element is hittable
- `verifyElementLabel(_:expectedLabel:)` - Assert element label matches

### Screenshot Methods
- `takeScreenshot(name:)` - Capture screenshot
- `saveScreenshot(name:)` - Save screenshot to TestContext

## Creating a New Page Object

### Step 1: Create the class file
```swift
import XCTest

class YourPageName: BasePage {
    // Implementation
}
```

### Step 2: Define element identifiers
```swift
private struct Identifiers {
    static let buttonId = "button_identifier"
    static let textFieldId = "textfield_identifier"
}
```

### Step 3: Create element properties
```swift
var submitButton: XCUIElement {
    return button(withIdentifier: Identifiers.buttonId)
}

var inputField: XCUIElement {
    return textField(withIdentifier: Identifiers.textFieldId)
}
```

### Step 4: Add action methods
```swift
@discardableResult
func enterText(_ text: String) -> YourPageName {
    typeText(inputField, text: text)
    return self
}

@discardableResult
func submitForm() -> NextPage {
    tap(submitButton)
    return NextPage(app: app)
}
```

### Step 5: Add verification methods
```swift
func verifyPageIsDisplayed() {
    verifyElementExists(submitButton)
    verifyElementExists(inputField)
}
```

## Usage Example

### In Test Class
```swift
func testNavigateToItems() throws {
    // Launch app
    TestContext.shared.launchFindMyApp()
    let app = TestContext.shared.getFindMyApp()
    
    // Create page object
    let mainPage = FindMyMainPage(app: app)
    
    // Verify and interact using page object methods
    mainPage.verifyMainPageIsDisplayed()
    mainPage.verifyAllTabsAreVisible()
    mainPage.navigateToItemsTab()
    mainPage.verifyItemsTabIsSelected()
}
```

### Method Chaining
```swift
func testUserFlow() throws {
    let app = TestContext.shared.getFindMyApp()
    
    FindMyMainPage(app: app)
        .verifyMainPageIsDisplayed()
        .navigateToDevicesTab()
        .verifyDevicesTabIsSelected()
}
```

## Best Practices

1. **One Page Object per Screen**: Create a separate page object for each distinct screen
2. **Use Meaningful Names**: Name elements and methods clearly to reflect their purpose
3. **Return Page Objects**: Action methods should return page objects for method chaining
4. **Encapsulate Waits**: Include waits in page object methods, not in tests
5. **Keep Tests Clean**: Tests should only call page object methods, not XCUIElement directly
6. **Use Identifiers Struct**: Group all element identifiers in a private struct
7. **Lazy Element Properties**: Use computed properties for elements (not stored properties)
8. **Verification Methods**: Add verification methods for common assertions
9. **Document Complex Flows**: Add comments for non-obvious interactions
10. **Update Identifiers**: Update identifiers based on actual app accessibility IDs

## Naming Conventions

- **Page Object Classes**: `[ScreenName]Page` (e.g., `FindMyMainPage`, `DevicesListPage`)
- **Element Properties**: Descriptive names ending in element type (e.g., `submitButton`, `emailTextField`)
- **Action Methods**: Verb-based (e.g., `navigateToDevicesTab()`, `enterEmail()`)
- **Verification Methods**: Start with `verify` (e.g., `verifyPageIsDisplayed()`)

## Future Page Objects

Consider creating page objects for:
- **DevicesListPage**: Devices tab content
- **ItemsListPage**: Items tab content  
- **MeProfilePage**: Me/Profile tab content
- **DeviceDetailPage**: Individual device details
- **ItemDetailPage**: Individual item details
- **MapPage**: Map view interactions
- **SearchPage**: Search functionality
- **SettingsPage**: Settings and preferences

## Integration with TestContext

Page objects work seamlessly with the TestContext singleton:

```swift
// Get app from TestContext
let app = TestContext.shared.getFindMyApp()
let page = FindMyMainPage(app: app)

// Save screenshots through page objects
page.saveScreenshot(name: "main_screen")

// Store page-related data
TestContext.shared.setTestData(key: "currentTab", value: "Devices")
```
