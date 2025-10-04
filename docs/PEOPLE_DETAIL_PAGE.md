# PeopleDetailPage - Page Object Documentation

## Overview

`PeopleDetailPage` represents the detail screen shown when you tap on a person in the FindMy app's People tab. This page displays detailed information about the selected person including their location, map view, and available actions.

## Usage

### Navigating to People Detail Page

From the main page:

```swift
let mainPage = FindMyMainPage(app: app)

// Navigate to People tab
mainPage.navigateToPeopleTab()

// Tap on a person to open detail page
let detailPage = mainPage.tapFirstPerson()

// Or tap by index
let detailPage = mainPage.tapPersonAtIndex(1)

// Or tap by name
let detailPage = mainPage.tapPersonByName("Jenny Le")
```

## Available Elements

### Navigation Elements
- `backButton` - Back button to return to main screen
- `doneButton` - Done button

### Person Information
- `personNameLabel` - Person's name
- `personAvatar` - Person's avatar image
- `locationLabel` - Current location text
- `lastSeenLabel` - Last seen time
- `addressLabel` - Address information

### Action Buttons
- `playSoundButton` - Play sound on person's device
- `directionsButton` - Get directions to location
- `notifyButton` - Enable/disable notify when found
- `removeButton` - Remove this person

### Map
- `mapView` - Map showing person's location

## Available Actions

### Navigation Actions

```swift
// Return to main page
let mainPage = detailPage.tapBackButton()

// Or use done button
let mainPage = detailPage.tapDoneButton()
```

### Person Actions

```swift
// Play sound on the person's device
detailPage.playSound()

// Get directions to person's location
detailPage.getDirections()

// Toggle notify when found
detailPage.toggleNotifyWhenFound()

// Remove person
detailPage.removePerson()
```

### Map Interaction

```swift
// Tap on the map
detailPage.tapMap()
```

## Verifications

### Basic Verifications

```swift
// Verify page is displayed
detailPage.verifyDetailPageIsDisplayed()

// Verify map is displayed
detailPage.verifyMapIsDisplayed()

// Verify back button is visible
detailPage.verifyBackButtonIsVisible()
```

### Content Verifications

```swift
// Verify person name
detailPage.verifyPersonName("Jenny Le")

// Verify location is displayed
detailPage.verifyLocationIsDisplayed()

// Verify action buttons
detailPage.verifyPlaySoundButtonIsVisible()
detailPage.verifyDirectionsButtonIsVisible()
```

## Helper Methods

### Get Information

```swift
// Get person's name
let name = detailPage.getPersonName()

// Get location text
let location = detailPage.getLocationText()

// Get last seen text
let lastSeen = detailPage.getLastSeenText()
```

### Check Button States

```swift
// Check if Play Sound is enabled
if detailPage.isPlaySoundEnabled() {
    detailPage.playSound()
}

// Check if Directions is enabled
if detailPage.isDirectionsEnabled() {
    detailPage.getDirections()
}
```

## Method Chaining

All action and verification methods return `self` or the appropriate page object, enabling method chaining:

```swift
detailPage
    .verifyDetailPageIsDisplayed()
    .verifyMapIsDisplayed()
    .verifyPersonName("Jenny Le")
    .playSound()
    .wait(2.0)
    .tapBackButton()
    .verifyMainPageIsDisplayed()
```

## Complete Test Example

```swift
@MainActor
func testPeopleDetailPage() throws {
    // Launch app
    TestContext.shared.launchFindMyApp()
    let app = TestContext.shared.getFindMyApp()
    
    // Navigate to People tab
    let mainPage = FindMyMainPage(app: app)
    mainPage
        .verifyMainPageIsDisplayed()
        .navigateToPeopleTab()
        .wait(2.0)
    
    // Open person detail
    let detailPage = mainPage.tapFirstPerson()
    
    // Verify and interact
    detailPage
        .verifyDetailPageIsDisplayed()
        .verifyMapIsDisplayed()
        .verifyPlaySoundButtonIsVisible()
        .wait(3.0)
        .saveScreenshot(name: "person_detail")
    
    // Navigate back
    detailPage
        .tapBackButton()
        .verifyMainPageIsDisplayed()
}
```

## Element Identifiers

### Current Identifiers (English)

| Element | Identifier/Label | Type |
|---------|-----------------|------|
| Back Button | "Back" | Button |
| Done Button | "Done" | Button |
| Play Sound | "Play Sound" | Button |
| Directions | "Directions" | Button |
| Notify | "Notify When Found" | Button |
| Remove | "Remove" | Button |
| Map View | (first map match) | Map |

**Note**: These identifiers are based on English localization. Update if your device uses a different language.

## Updating Identifiers

If UI inspection reveals different identifiers:

1. Run UI inspection on the detail page:
```swift
// Add to inspection test
mainPage.tapFirstPerson()
// Inspect elements here
```

2. Update `PeopleDetailPage.swift`:
```swift
private struct Identifiers {
    static let playSound = "actual_identifier_here"
    // ...
}
```

## Tips

### Wait for Page Load
```swift
let detailPage = mainPage.tapFirstPerson()
detailPage.wait(2.0)  // Wait for page to load
detailPage.verifyDetailPageIsDisplayed()
```

### Handle Different States
```swift
// Check if action is available before using
if detailPage.isPlaySoundEnabled() {
    detailPage.playSound()
} else {
    print("Play Sound not available")
}
```

### Screenshot for Debugging
```swift
detailPage
    .verifyDetailPageIsDisplayed()
    .saveScreenshot(name: "debug_detail_page")
```

## Related Pages

- **[FindMyMainPage](PAGE_OBJECTS_README.md)** - Main screen with tab navigation
- **[BasePage](PAGE_OBJECTS_README.md)** - Base page object with common methods

## Future Enhancements

Potential additions:
- Scroll to specific sections
- Interact with map annotations
- Handle share location dialog
- Verify battery level display
- Test notification settings
- Handle location permission prompts

---

**File**: `FindMeAppCTLTestUITests/PageObjects/PeopleDetailPage.swift`
