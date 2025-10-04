# FindMy App UI Structure

## Overview

This document describes the actual UI structure of Apple's FindMy app based on UI inspection results.

## Important Notes

### Localization
The FindMy app UI is **localized**. The page objects are configured for **English** localization:
- **People**: "People"
- **Devices**: "Devices"  
- **Items**: "Items"
- **Me**: "Me"

**Note**: If your device uses a different language, you'll need to update the identifiers in `FindMyMainPage.swift` to match your device's language.

### No Standard Tab Bar
FindMy does **not** use a standard `UITabBar`. Instead, it uses custom buttons at the bottom of the screen. This is why we query for buttons by label rather than using tab bar methods.

## UI Hierarchy

```
Application (com.apple.findmy)
└── Window
    └── CardContainerView (identifier: "CardContainerView")
        ├── Card Content Area
        │   ├── FindMyListEntries (identifier: "FindMyListEntries")
        │   │   ├── Add Button (identifier: "FindMyListViewAddAction")
        │   │   └── Table
        │   │       ├── List Title (identifier: "FindMyListViewTitle")
        │   │       └── Cells (identifier: "HomeElementCell")
        │   │           ├── Title Label (identifier: "HomeCellTitleLabel")
        │   │           └── Subtitle Label (identifier: "HomeCellSubtitleLabel")
        │   └── Map View
        └── Bottom Navigation
            ├── People Button (label: "Personer")
            ├── Devices Button (label: "Enheter")
            ├── Items Button (label: "Föremål")
            └── Me Button (label: "Jag")
```

## Key Elements

### Bottom Navigation Buttons

| Element | Label (English) | Identifier | Selected by Default |
|---------|-----------------|------------|---------------------|
| People | People | (none) | ✅ Yes |
| Devices | Devices | (none) | No |
| Items | Items | (none) | No |
| Me | Me | (none) | No |

**Query Method**: Use `app.buttons[label]` to find these elements.

### Main Content Area

| Element | Identifier | Description |
|---------|-----------|-------------|
| Card Container | `CardContainerView` | Main content container |
| List Entries | `FindMyListEntries` | Container for list view |
| Add Button | `FindMyListViewAddAction` | Button to add new items |
| List Title | `FindMyListViewTitle` | Title of current list |
| Table | (none) | Use `app.tables.firstMatch` |

### List Cells

Each cell in the list has:
- **Cell**: identifier `HomeElementCell`
- **Title**: identifier `HomeCellTitleLabel` (e.g., "Jenny Le", "kevin@family-le.com")
- **Subtitle**: identifier `HomeCellSubtitleLabel` (e.g., "Lund , Nu", "Lund , För 6 min sen")
- **Icon**: identifier `sidebarIconView`

## Inspection Results Summary

From the UI inspection test:

### Buttons Found: 7
1. **Kartlägen** - Map layers button
2. **Spårning** - Tracking button (disabled)
3. **lägg till** - Add button (identifier: `FindMyListViewAddAction`)
4. **Personer** - People tab (selected)
5. **Enheter** - Devices tab
6. **Föremål** - Items tab
7. **Jag** - Me tab

### Tables Found: 1
- Main list table with 3 cells (in the inspection example)
- No accessibility identifier
- Query using: `app.tables.firstMatch`

### Other Elements
- **Maps**: 1 (map view in background)
- **Images**: 3 (profile icons)
- **Static Texts**: 11 (labels and titles)
- **Tab Bars**: 0 (uses custom buttons instead)
- **Navigation Bars**: 0 (custom navigation)

## Page Object Updates

### FindMyMainPage.swift

Updated with actual identifiers:

```swift
private struct Identifiers {
    // Tab buttons (localized labels - English)
    static let peopleTab = "People"
    static let devicesTab = "Devices"
    static let itemsTab = "Items"
    static let meTab = "Me"
    
    // List view
    static let listViewTitle = "FindMyListViewTitle"
    static let addButton = "FindMyListViewAddAction"
    static let cardContainer = "CardContainerView"
    static let listEntries = "FindMyListEntries"
    
    // Cell identifiers
    static let homeCell = "HomeElementCell"
    static let cellTitle = "HomeCellTitleLabel"
    static let cellSubtitle = "HomeCellSubtitleLabel"
}
```

### New Methods Added

- `navigateToPeopleTab()` - Navigate to People tab
- `verifyPeopleTabIsSelected()` - Verify People tab is selected
- `tapAddButton()` - Tap the add button
- `verifyListTableIsDisplayed()` - Verify list table exists
- `getListItemCount()` - Get number of items in list

## Localization Handling

### Current Approach
Using hardcoded English labels. This works but is language-specific.

### Alternative Approaches

#### 1. Query by Position
```swift
// Get bottom buttons by position
let bottomButtons = app.buttons.allElementsBoundByIndex.suffix(4)
let peopleButton = bottomButtons[0]
let devicesButton = bottomButtons[1]
// etc.
```

#### 2. Query by isSelected State
```swift
// Find selected tab
let selectedTab = app.buttons.matching(NSPredicate(format: "isSelected == true")).firstMatch
```

#### 3. Use Accessibility Identifiers (if available)
Unfortunately, FindMy doesn't provide accessibility identifiers for tab buttons.

### Recommended Solution
Keep the current approach with localized strings, but:
1. Document the language dependency
2. Provide a configuration option for different languages
3. Add a helper method to detect and set language

## Testing Considerations

### What Works
- ✅ Navigating between tabs
- ✅ Verifying tab selection
- ✅ Accessing list items
- ✅ Counting list items
- ✅ Taking screenshots

### Limitations
- ⚠️ Language-dependent (requires localized strings)
- ⚠️ No standard accessibility identifiers for tabs
- ⚠️ Map interactions not yet implemented
- ⚠️ Cell interactions need more work

### Future Enhancements
1. Create `PeopleListPage` for People tab content
2. Create `DevicesListPage` for Devices tab content
3. Create `ItemsListPage` for Items tab content
4. Create `MeProfilePage` for Me tab content
5. Add methods to interact with list cells
6. Add methods to interact with map view
7. Add language detection/configuration

## Example Test

```swift
func testNavigateThroughTabs() throws {
    TestContext.shared.launchFindMyApp()
    let app = TestContext.shared.getFindMyApp()
    
    let mainPage = FindMyMainPage(app: app)
    
    // Verify main page
    mainPage.verifyMainPageIsDisplayed()
    mainPage.verifyAllTabsAreVisible()
    
    // Navigate through tabs
    mainPage
        .verifyPeopleTabIsSelected()  // Default tab
        .navigateToDevicesTab()
        .verifyDevicesTabIsSelected()
        .navigateToItemsTab()
        .verifyItemsTabIsSelected()
        .navigateToMeTab()
        .verifyMeTabIsSelected()
}
```

## Troubleshooting

### Tabs Not Found
**Issue**: Test can't find tab buttons  
**Solution**: Check device language. Update identifiers in `FindMyMainPage.swift` to match your device's language.

### Wrong Tab Selected
**Issue**: `isSelected` assertion fails  
**Solution**: Add wait time after navigation to allow UI to update:
```swift
mainPage.navigateToDevicesTab()
mainPage.wait(1.0)  // Wait for selection to update
mainPage.verifyDevicesTabIsSelected()
```

### List Not Found
**Issue**: Can't find list table  
**Solution**: Ensure you're on a tab that shows a list (People, Devices, or Items).

## References

- UI Inspection Test: `testInspectFindMyAppUI` in `FindMeAppCTLTestUITests.swift`
- Page Object: `FindMyMainPage.swift`
- Base Page: `BasePage.swift`
- Test Context: `TestContext.swift`
