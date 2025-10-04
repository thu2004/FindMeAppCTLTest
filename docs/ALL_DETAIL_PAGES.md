# All Detail Pages - Complete Reference

## Overview

Complete page object implementation for all FindMy app detail pages across all tab types.

## Page Objects

### 1. PeopleDetailPage
**File**: `PageObjects/PeopleDetailPage.swift`  
**Purpose**: Detail screen for a person/contact in the People tab

#### Key Elements
- Close button: "Close"
- Contact: "Contact,Info"
- Directions: "Directions, "
- Add to Favourites
- Label Current Location
- Stop Sharing My Location
- Remove
- Map view

#### Usage
```swift
let mainPage = FindMyMainPage(app: app)
    .navigateToPeopleTab()

let detailPage = mainPage
    .tapFirstPerson()
    .verifyDetailPageIsDisplayed()
    .verifyMapIsDisplayed()
    .tapContact()
    .tapCloseButton()
```

### 2. DeviceDetailPage
**File**: `PageObjects/DeviceDetailPage.swift`  
**Purpose**: Detail screen for a device (iPhone, iPad, Mac, etc.) in the Devices tab

#### Key Elements
- Close button: "Close"
- Play Sound
- Directions
- Mark As Lost
- Erase This Device
- Remove This Device
- Notify When Found
- Map view

#### Usage
```swift
let mainPage = FindMyMainPage(app: app)
    .navigateToDevicesTab()

let detailPage = mainPage
    .tapFirstDevice()
    .verifyDetailPageIsDisplayed()
    .verifyPlaySoundButtonIsVisible()
    .playSound()
    .tapCloseButton()
```

### 3. ItemDetailPage
**File**: `PageObjects/ItemDetailPage.swift`  
**Purpose**: Detail screen for an AirTag or item in the Items tab

#### Key Elements
- Close button: "Close"
- Play Sound
- Find Nearby (Precision Finding)
- Directions
- Lost Mode
- Remove Item
- Notify When Found
- Identify Found Item
- Map view
- Battery level

#### Usage
```swift
let mainPage = FindMyMainPage(app: app)
    .navigateToItemsTab()

let detailPage = mainPage
    .tapFirstItem()
    .verifyDetailPageIsDisplayed()
    .verifyFindNearbyButtonIsVisible()
    .findNearby()
    .tapCloseButton()
```

## Navigation Methods

### From FindMyMainPage

#### People Navigation
```swift
// By index
mainPage.tapPersonAtIndex(0) -> PeopleDetailPage

// By name
mainPage.tapPersonByName("Jenny Le") -> PeopleDetailPage

// First person
mainPage.tapFirstPerson() -> PeopleDetailPage
```

#### Device Navigation
```swift
// By index
mainPage.tapDeviceAtIndex(0) -> DeviceDetailPage

// By name
mainPage.tapDeviceByName("Chi Thu's iPhone") -> DeviceDetailPage

// First device
mainPage.tapFirstDevice() -> DeviceDetailPage
```

#### Item Navigation
```swift
// By index
mainPage.tapItemAtIndex(0) -> ItemDetailPage

// By name
mainPage.tapItemByName("Keys") -> ItemDetailPage

// First item
mainPage.tapFirstItem() -> ItemDetailPage
```

## Common Patterns

### All Detail Pages Support

#### Navigation Back
```swift
detailPage.tapCloseButton() -> FindMyMainPage
detailPage.tapDoneButton() -> FindMyMainPage
```

#### Map Interaction
```swift
detailPage
    .verifyMapIsDisplayed()
    .tapMap()
```

#### Method Chaining
```swift
detailPage
    .verifyDetailPageIsDisplayed()
    .verifyMapIsDisplayed()
    .wait(2.0)
    .saveScreenshot(name: "detail_page")
    .tapCloseButton()
```

## Comprehensive Inspection Test

### testInspectAllTabsAndDetails

New test that inspects all tabs and their detail pages:

```swift
@MainActor
func testInspectAllTabsAndDetails() throws {
    // Inspects:
    // - People Tab + People Detail
    // - Devices Tab + Device Detail
    // - Items Tab + Item Detail
    // - Me Tab
    
    // Captures screenshots for each
    // Prints all buttons, cells, and static texts
}
```

**Run with:**
```bash
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=YOUR_DEVICE_ID' \
  -only-testing:FindMyUIInspectionTests/testInspectAllTabsAndDetails
```

## Feature Comparison

| Feature | People | Devices | Items |
|---------|--------|---------|-------|
| Play Sound | ❌ | ✅ | ✅ |
| Directions | ✅ | ✅ | ✅ |
| Map View | ✅ | ✅ | ✅ |
| Contact | ✅ | ❌ | ❌ |
| Find Nearby | ❌ | ❌ | ✅ |
| Mark As Lost | ❌ | ✅ | ❌ |
| Lost Mode | ❌ | ❌ | ✅ |
| Erase Device | ❌ | ✅ | ❌ |
| Remove | ✅ | ✅ | ✅ |
| Battery Info | ❌ | ❌ | ✅ |

## Complete Test Example

```swift
@MainActor
func testAllDetailPages() throws {
    TestContext.shared.launchFindMyApp()
    let app = TestContext.shared.getFindMyApp()
    let mainPage = FindMyMainPage(app: app)
    
    // Test People Detail
    mainPage
        .navigateToPeopleTab()
        .wait(2.0)
    
    let peopleDetail = mainPage.tapFirstPerson()
    peopleDetail
        .verifyDetailPageIsDisplayed()
        .verifyMapIsDisplayed()
        .saveScreenshot(name: "people_detail")
        .tapCloseButton()
    
    // Test Device Detail
    mainPage
        .navigateToDevicesTab()
        .wait(2.0)
    
    let deviceDetail = mainPage.tapFirstDevice()
    deviceDetail
        .verifyDetailPageIsDisplayed()
        .verifyPlaySoundButtonIsVisible()
        .saveScreenshot(name: "device_detail")
        .tapCloseButton()
    
    // Test Item Detail
    mainPage
        .navigateToItemsTab()
        .wait(2.0)
    
    let itemDetail = mainPage.tapFirstItem()
    itemDetail
        .verifyDetailPageIsDisplayed()
        .verifyFindNearbyButtonIsVisible()
        .saveScreenshot(name: "item_detail")
        .tapCloseButton()
}
```

## Updating Identifiers

After running `testInspectAllTabsAndDetails`, update identifiers in each page object based on actual UI:

### Example Update Process

1. **Run inspection test**:
```bash
make inspect-ui
# or
xcodebuild test [...] -only-testing:FindMyUIInspectionTests/testInspectAllTabsAndDetails
```

2. **Review output** for each tab's detail page

3. **Update identifiers** in respective page objects:
   - `PeopleDetailPage.swift`
   - `DeviceDetailPage.swift`
   - `ItemDetailPage.swift`

4. **Verify** with actual tests

## Files

- **Page Objects**:
  - `PageObjects/PeopleDetailPage.swift`
  - `PageObjects/DeviceDetailPage.swift`
  - `PageObjects/ItemDetailPage.swift`
  - `PageObjects/FindMyMainPage.swift` (navigation methods)

- **Tests**:
  - `FindMyUIInspectionTests.swift` - Comprehensive inspection
  - `FindMeAppCTLTestUITests.swift` - Usage examples

- **Documentation**:
  - `docs/PEOPLE_DETAIL_PAGE.md` - People detail docs
  - `docs/ALL_DETAIL_PAGES.md` - This file

## Best Practices

1. **Always navigate to correct tab first**
```swift
mainPage.navigateToDevicesTab()
let detail = mainPage.tapFirstDevice()
```

2. **Verify page is displayed**
```swift
detailPage.verifyDetailPageIsDisplayed()
```

3. **Use method chaining**
```swift
detailPage
    .verifyDetailPageIsDisplayed()
    .playSound()
    .wait(2.0)
    .tapCloseButton()
```

4. **Take screenshots for debugging**
```swift
detailPage.saveScreenshot(name: "debug_state")
```

5. **Check button states before actions**
```swift
if detailPage.isPlaySoundEnabled() {
    detailPage.playSound()
}
```

---

**All detail pages are ready for comprehensive UI testing!** 🎉
