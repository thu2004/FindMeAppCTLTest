# Page Objects Guide

Complete guide to all page objects in the FindMy app UI test framework.

## Overview

The page object pattern provides a clean separation between test code and UI interaction code. Each page object represents a screen or component in the FindMy app.

## Page Object Architecture

```
BasePage (Abstract base class)
├── All common functionality
├── Swipe gestures
├── Wait methods
└── Scroll utilities

All page objects inherit from BasePage
```

## Complete Page Object List

### Core Pages

1. **FindMyMainPage** - Main app screen with tabs
2. **DeviceDetailPage** - Device details and actions
3. **ItemDetailPage** - Item (AirTag) details and actions
4. **PeopleDetailPage** - People/contacts details

### New Pages (Added 2025-10-05)

5. **MePage** - Me tab and user settings
6. **ItemRenamePage** - Rename items workflow
7. **RemoveObjectPage** - Remove items/devices workflow
8. **ContactSelectPage** - Select contacts for sharing
9. **ItemSharingPage** - Share items with contacts
10. **LostItemDetailPage** - View lost item details
11. **AddItemPage** - Add new items menu
12. **ItemPairingPage** - Pair new items

---

## Detailed Page Object Reference

### 1. FindMyMainPage

**Purpose**: Main landing page with navigation tabs

**Key Elements**:
- Tab bar (Devices, Items, People, Me)
- Map view
- Card container
- Add button

**Common Actions**:
```swift
let mainPage = FindMyMainPage(app: app)

// Navigation
mainPage.navigateToDevicesTab()
mainPage.navigateToItemsTab()
mainPage.navigateToPeopleTab()

// Verification
mainPage.verifyMainPageIsDisplayed()

// Device interaction
let devicePage = mainPage.tapFirstDevice()
```

---

### 2. DeviceDetailPage

**Purpose**: View and control device details

**Key Elements**:
- Device name and location
- Play Sound button
- Directions button
- Lost Mode toggle
- Erase Device button
- Remove Device button
- Notify When Found switch

**Common Actions**:
```swift
let devicePage = DeviceDetailPage(app: app)

// Verification
devicePage.verifyDetailPageIsDisplayed()

// Actions
devicePage.playSound()
devicePage.getDirections()
devicePage.enableLostMode()
devicePage.tapRemoveButton()

// Information
let location = devicePage.getLocation()
let battery = devicePage.getBatteryLevel()
```

---

### 3. ItemDetailPage

**Purpose**: View and control item (AirTag) details

**Key Elements**:
- Item name and location
- Play Sound button
- Find button
- Rename button
- Share button
- Lost Mode toggle
- Notify When Found switch

**Common Actions**:
```swift
let itemPage = ItemDetailPage(app: app)

// Verification
itemPage.verifyDetailPageIsDisplayed()

// Actions
itemPage.playSound()
itemPage.tapFindButton()
itemPage.tapRenameButton()
itemPage.tapShareButton()

// Information
let name = itemPage.getItemName()
let location = itemPage.getLocation()
```

---

### 4. PeopleDetailPage

**Purpose**: View and manage people/contacts

**Key Elements**:
- Contact name
- Location sharing status
- Share My Location button
- Stop Sharing button

**Common Actions**:
```swift
let peoplePage = PeopleDetailPage(app: app)

// Verification
peoplePage.verifyDetailPageIsDisplayed()

// Actions
peoplePage.tapShareMyLocation()
peoplePage.tapStopSharing()

// Information
let name = peoplePage.getContactName()
let status = peoplePage.getSharingStatus()
```

---

### 5. MePage

**Purpose**: User profile and settings

**Key Elements**:
- Me title
- Clear Ignored Items button

**Common Actions**:
```swift
let mePage = MePage(app: app)

// Navigation
mePage.navigateToMeTab()

// Verification
mePage.verifyMePageIsDisplayed()

// Actions
mePage.tapClearIgnoredItems()
mePage.handleClearIgnoredPopup(confirm: true)
```

---

### 6. ItemRenamePage

**Purpose**: Rename items

**Key Elements**:
- Name text field
- Done button
- Cancel button
- Clear text button

**Common Actions**:
```swift
let renamePage = ItemRenamePage(app: app)

// Verification
renamePage.verifyRenamePageIsDisplayed()

// Actions
renamePage.enterName("My AirTag")
renamePage.tapDone()

// Complete flow
renamePage.renameItem(to: "New Name")
```

---

### 7. RemoveObjectPage

**Purpose**: Confirm object removal

**Key Elements**:
- Object name
- Owner name
- Remove button
- Cancel button
- Progress indicator

**Common Actions**:
```swift
let removePage = RemoveObjectPage(app: app)

// Verification
removePage.verifyRemovePageIsDisplayed()
removePage.verifyObjectName("iPhone")

// Actions
removePage.tapRemove()
removePage.waitForRemovalToComplete()

// Complete flow
removePage.removeObject()

// Information
let name = removePage.getDeviceName()
let owner = removePage.getOwnerName()
```

---

### 8. ContactSelectPage

**Purpose**: Select contacts for sharing

**Key Elements**:
- Search field (To field)
- Results list
- Send/Done button
- Cancel button

**Common Actions**:
```swift
let contactPage = ContactSelectPage(app: app)

// Verification
contactPage.verifyContactSelectPageIsDisplayed()

// Actions
contactPage.enterContact("john@example.com")
contactPage.selectFirstContact()
contactPage.tapSend()

// Complete flow
contactPage.selectAndSendContact("john@example.com")

// Information
let count = contactPage.getContactCount()
let exists = contactPage.contactExists("John")
```

---

### 9. ItemSharingPage

**Purpose**: Share items with contacts

**Contains 3 classes**:
- `ItemSharingPage` - Main sharing flow
- `ItemSharingResponsePage` - Accept/decline
- `StopSharingPage` - Stop sharing

**Common Actions**:
```swift
// Main sharing
let sharingPage = ItemSharingPage(app: app)
sharingPage.tapContinue()
sharingPage.tapShare()
sharingPage.completeSharing()

// Accept shared item
let responsePage = ItemSharingResponsePage(app: app)
responsePage.tapAccept()

// Stop sharing
let stopPage = StopSharingPage(app: app)
stopPage.tapStopSharing()
```

---

### 10. LostItemDetailPage

**Purpose**: View lost item details

**Key Elements**:
- Item type label
- Location button
- Location age
- Play Sound button
- Owner info
- Serial number

**Common Actions**:
```swift
let lostItemPage = LostItemDetailPage(app: app)

// Verification
lostItemPage.verifyLostItemDetailPageIsDisplayed()
lostItemPage.verifyItemType("AirTag")

// Actions
lostItemPage.tapPlaySound()
lostItemPage.stopPlayingSound()
lostItemPage.tapLocation()

// Information
let type = lostItemPage.getItemType()
let location = lostItemPage.getLocation()
let age = lostItemPage.getLocationAge()
let hasLoc = lostItemPage.hasLocation()
let playing = lostItemPage.isSoundPlaying()
```

---

### 11. AddItemPage

**Purpose**: Add new items menu

**Key Elements**:
- Add AirTag button
- Add Apple Pencil button
- Add Other Item button
- Share My Location button

**Common Actions**:
```swift
let addPage = AddItemPage(app: app)

// Verification
addPage.verifyAddItemMenuIsDisplayed()

// Actions
addPage.tapAddAirTag()
addPage.tapAddApplePencil()
addPage.tapAddOtherItem()

// Complete flows
addPage.startAddingAirTag()
addPage.startAddingApplePencil()
```

---

### 12. ItemPairingPage

**Purpose**: Pair new items

**Key Elements**:
- Connect button
- Continue button
- Agree button
- Done button

**Common Actions**:
```swift
let pairingPage = ItemPairingPage(app: app)

// Verification
pairingPage.verifyPairingPageIsDisplayed()

// Actions
pairingPage.tapConnect()
pairingPage.tapContinue()
pairingPage.tapAgree()
pairingPage.tapDone()

// Complete flow
pairingPage.completePairing()
```

---

## Common Patterns

### Pattern 1: Verification

All page objects have verification methods:

```swift
// Check if page is displayed
func verifyPageIsDisplayed() {
    XCTAssertTrue(element.waitForExistence(timeout: defaultTimeout),
                 "Page should be displayed")
}

// Check without assertion
func isPageDisplayed() -> Bool {
    return element.exists
}
```

### Pattern 2: Actions

Action methods follow consistent naming:

```swift
// Tap actions
func tapButton() {
    XCTAssertTrue(button.waitForExistence(timeout: defaultTimeout),
                 "Button should exist")
    button.tap()
    wait(1.0)
}

// Complete workflows
func completeFlow() {
    verifyPageIsDisplayed()
    tapButton1()
    tapButton2()
    tapDone()
}
```

### Pattern 3: Information Retrieval

Get information from page elements:

```swift
func getName() -> String {
    return nameLabel.label
}

func getCount() -> Int {
    return list.count
}

func hasElement() -> Bool {
    return element.exists
}
```

---

## Test Examples

### Example 1: Complete Device Test

```swift
func testDevicePlaySound() throws {
    let mainPage = FindMyMainPage(app: app)
    let devicePage = DeviceDetailPage(app: app)
    let alertHelper = AlertHelper(app: app)
    
    // Navigate
    mainPage.verifyMainPageIsDisplayed()
    mainPage.navigateToDevicesTab()
    
    // Open device
    let device = mainPage.tapFirstDevice()
    device.verifyDetailPageIsDisplayed()
    
    // Play sound
    device.playSound()
    
    // Handle alert
    if let alert = alertHelper.waitForAlert(timeout: 10.0) {
        alertHelper.tapOK(in: alert)
    }
    
    // Close
    device.tapCloseButton()
}
```

### Example 2: Rename Item Test

```swift
func testRenameItem() throws {
    let mainPage = FindMyMainPage(app: app)
    let itemPage = ItemDetailPage(app: app)
    let renamePage = ItemRenamePage(app: app)
    
    // Navigate to item
    mainPage.navigateToItemsTab()
    let item = mainPage.tapFirstItem()
    
    // Open rename
    item.tapRenameButton()
    
    // Rename
    renamePage.renameItem(to: "My New AirTag")
    
    // Verify
    item.verifyDetailPageIsDisplayed()
    XCTAssertTrue(item.getItemName().contains("My New AirTag"))
}
```

### Example 3: Share Item Test

```swift
func testShareItem() throws {
    let mainPage = FindMyMainPage(app: app)
    let itemPage = ItemDetailPage(app: app)
    let contactPage = ContactSelectPage(app: app)
    let sharingPage = ItemSharingPage(app: app)
    
    // Navigate to item
    mainPage.navigateToItemsTab()
    let item = mainPage.tapFirstItem()
    
    // Start sharing
    item.tapShareButton()
    
    // Select contact
    contactPage.selectAndSendContact("test@example.com")
    
    // Complete sharing
    sharingPage.completeSharing()
    
    // Verify
    item.verifyDetailPageIsDisplayed()
}
```

### Example 4: Remove Device Test

```swift
func testRemoveDevice() throws {
    let mainPage = FindMyMainPage(app: app)
    let devicePage = DeviceDetailPage(app: app)
    let removePage = RemoveObjectPage(app: app)
    
    // Navigate to device
    mainPage.navigateToDevicesTab()
    let device = mainPage.tapFirstDevice()
    
    // Start removal
    device.tapRemoveButton()
    
    // Confirm removal
    removePage.verifyObjectName("iPhone")
    removePage.removeObject()
    
    // Verify back at main page
    mainPage.verifyMainPageIsDisplayed()
}
```

### Example 5: Add AirTag Test

```swift
func testAddAirTag() throws {
    let mainPage = FindMyMainPage(app: app)
    let addPage = AddItemPage(app: app)
    let pairingPage = ItemPairingPage(app: app)
    
    // Open add menu
    mainPage.tapAddButton()
    
    // Start adding AirTag
    addPage.startAddingAirTag()
    
    // Complete pairing
    pairingPage.completePairing()
    
    // Verify back at main page
    mainPage.verifyMainPageIsDisplayed()
}
```

---

## Best Practices

### 1. Always Verify Page State

```swift
// Good
func testExample() {
    page.verifyPageIsDisplayed()
    page.tapButton()
}

// Bad
func testExample() {
    page.tapButton() // May fail if page not loaded
}
```

### 2. Use Complete Flow Methods

```swift
// Good
renamePage.renameItem(to: "New Name")

// Less ideal
renamePage.enterName("New Name")
renamePage.tapDone()
```

### 3. Handle Alerts and Popups

```swift
// Always handle potential alerts
device.playSound()

let alertHelper = AlertHelper(app: app)
if let alert = alertHelper.waitForAlert(timeout: 5.0) {
    alertHelper.tapOK(in: alert)
}
```

### 4. Clean Up After Tests

```swift
override func tearDownWithError() throws {
    // Close any open pages
    if devicePage.isDetailPageDisplayed() {
        devicePage.tapCloseButton()
    }
    
    // Clear notifications
    notificationHelper.clearAllNotifications()
    
    TestContext.shared.terminateFindMyApp()
}
```

### 5. Use Information Methods for Assertions

```swift
// Good
let name = device.getDeviceName()
XCTAssertEqual(name, "iPhone", "Device name should match")

// Less ideal
XCTAssertTrue(device.deviceNameLabel.label == "iPhone")
```

---

## Integration with Helpers

Page objects work seamlessly with helper classes:

```swift
func testWithHelpers() {
    let mainPage = FindMyMainPage(app: app)
    let devicePage = DeviceDetailPage(app: app)
    let notificationHelper = NotificationHelper()
    let alertHelper = AlertHelper(app: app)
    
    // Use page objects for navigation
    mainPage.navigateToDevicesTab()
    let device = mainPage.tapFirstDevice()
    
    // Use page objects for actions
    device.playSound()
    
    // Use helpers for system interactions
    if let alert = alertHelper.waitForAlert() {
        alertHelper.tapOK(in: alert)
    }
    
    let notification = notificationHelper.waitForNotification(
        withText: "sound",
        openCenter: true
    )
    
    // Back to page objects
    device.tapCloseButton()
}
```

---

## Troubleshooting

### Page Not Displayed

```swift
// Check if page exists
if !page.isPageDisplayed() {
    print("Page not displayed, current state:")
    app.debugDescription
}

// Increase timeout
page.verifyPageIsDisplayed() // Uses default timeout
page.element.waitForExistence(timeout: 20.0) // Custom timeout
```

### Element Not Found

```swift
// Print all elements
print(app.debugDescription)

// Check element exists before interaction
if button.exists {
    button.tap()
} else {
    print("Button not found")
}
```

### Timing Issues

```swift
// Add explicit waits
page.wait(2.0)

// Wait for element
button.waitForExistence(timeout: 10.0)

// Wait for element to disappear
let predicate = NSPredicate(format: "exists == false")
let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
XCTWaiter.wait(for: [expectation], timeout: 10.0)
```

---

## See Also

- [Notification Testing Guide](NOTIFICATION_TESTING.md)
- [Alert Testing Guide](ALERT_TESTING.md)
- [Test Helpers Summary](../TEST_HELPERS_SUMMARY.md)
- [New Page Objects Summary](../NEW_PAGE_OBJECTS_SUMMARY.md)
