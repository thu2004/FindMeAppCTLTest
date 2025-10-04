# UI Inspection Workflow

## Purpose

Use `FindMyUIInspectionTests` to capture FindMy app UI structure and update page objects when the app changes or when testing on different devices/languages.

## When to Run UI Inspection

Run the inspection test when:
- ✅ **App updates** - FindMy app UI changes after iOS update
- ✅ **New device** - Testing on a device with different language
- ✅ **New features** - Apple adds new features to FindMy
- ✅ **Page object updates** - Need to verify element identifiers
- ✅ **Debugging** - Tests are failing and you need to see actual UI structure

## Workflow

### 1. Run UI Inspection Test

```bash
# Command line (device must be unlocked!)
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests/FindMyUIInspectionTests \
  2>&1 | tee ui_inspection_$(date +%Y%m%d_%H%M%S).log

# Or in Xcode (easier)
# 1. Open FindMyUIInspectionTests.swift
# 2. Unlock device
# 3. Click diamond icon next to testInspectFindMyAppUI
# 4. View output in Report Navigator (Cmd+9)
```

### 2. Review Inspection Output

The test prints:
- **Full App Hierarchy** - Complete XML structure
- **All Buttons** - Labels, identifiers, states
- **Tab Bars** - Tab structure (if any)
- **Navigation Bars** - Nav bar elements
- **Static Texts** - Text labels
- **Tables** - List structures
- **Collection Views** - Grid structures
- **Other Elements** - Counts of all UI types

### 3. Extract Key Information

Look for:

#### **Tab Buttons**
```
Button 3:
  - Label: 'People'
  - Identifier: ''
  - isSelected: false
  
Button 4:
  - Label: 'Devices'
  - Identifier: ''
  - isSelected: false
```

#### **Identifiers**
```
Button 2:
  - Label: 'add'
  - Identifier: 'FindMyBaseViewAddAction'  ← Use this!
```

#### **List Elements**
```
Table 0:
  - Identifier: ''
  - Cells: 3
  
Cell:
  - Identifier: 'HomeElementCell'  ← Use this!
```

### 4. Update Page Objects

Based on inspection results, update `FindMyMainPage.swift`:

#### **Example: Tab Labels Changed**

**Inspection shows:**
```
Button 3: Label: 'Contacts'  (was 'People')
Button 4: Label: 'My Devices' (was 'Devices')
```

**Update identifiers:**
```swift
private struct Identifiers {
    static let peopleTab = "Contacts"      // Updated!
    static let devicesTab = "My Devices"   // Updated!
    static let itemsTab = "Items"
    static let meTab = "Me"
}
```

#### **Example: New Identifier Found**

**Inspection shows:**
```
Button 2:
  - Identifier: 'FindMyBaseViewAddAction'
```

**Update page object:**
```swift
private struct Identifiers {
    static let addButton = "FindMyBaseViewAddAction"  // Updated!
}
```

### 5. Verify Changes

After updating page objects:

```bash
# Build to check for errors
make build

# Run navigation tests to verify
make test-device-tabs
```

## Inspection Test Details

### What It Captures

| Element Type | Information Captured |
|-------------|---------------------|
| Buttons | Label, Identifier, Value, isSelected, isEnabled |
| Tab Bars | Structure, buttons, selection state |
| Navigation Bars | Label, Identifier |
| Static Texts | Label, Identifier |
| Tables | Identifier, Cell count |
| Collection Views | Identifier, Cell count |
| Other | Counts of all UI element types |

### Output Format

```
================================================================================
FINDMY APP UI INSPECTION - [timestamp]
================================================================================

📱 FULL APP HIERARCHY:
[Complete XML structure]

🔘 ALL BUTTONS:
Button 0:
  - Label: 'Map Modes'
  - Identifier: ''
  - isSelected: false
  - isEnabled: true
[...]

📊 TAB BARS:
[Tab bar structure]

🧭 NAVIGATION BARS:
[Navigation structure]

📝 STATIC TEXTS:
[Text elements]

📋 TABLES:
[Table structure]

🗂️ COLLECTION VIEWS:
[Collection structure]

🔍 OTHER ELEMENTS:
Switches: 2
TextFields: 0
[...]

================================================================================
END OF UI INSPECTION
================================================================================
```

## Common Update Scenarios

### Scenario 1: Language Change

**Device language changed from English to Spanish**

1. Run inspection test
2. Note new labels:
   - "People" → "Personas"
   - "Devices" → "Dispositivos"
   - "Items" → "Artículos"
   - "Me" → "Yo"
3. Update `FindMyMainPage.swift` identifiers
4. Run tests to verify

### Scenario 2: iOS Update

**iOS update changes UI structure**

1. Run inspection test
2. Compare with previous inspection
3. Note differences:
   - New buttons added
   - Identifiers changed
   - Element hierarchy changed
4. Update page objects accordingly
5. Update tests if needed

### Scenario 3: New Feature

**FindMy adds new tab or feature**

1. Run inspection test
2. Identify new elements
3. Create new page object if needed
4. Add new identifiers to existing page objects
5. Write tests for new feature

## Best Practices

### 1. Save Inspection Logs

```bash
# Save with timestamp
xcodebuild test [...] 2>&1 | tee inspections/ui_$(date +%Y%m%d_%H%M%S).log

# Create inspections directory
mkdir -p inspections
```

### 2. Compare Inspections

```bash
# Compare two inspection logs
diff inspections/ui_20251004_100000.log inspections/ui_20251004_110000.log
```

### 3. Document Changes

When updating page objects, document why:

```swift
private struct Identifiers {
    // Updated 2025-10-04: iOS 26.1 changed label from "People" to "Contacts"
    static let peopleTab = "Contacts"
}
```

### 4. Version Control

Commit inspection logs with page object updates:

```bash
git add FindMeAppCTLTestUITests/PageObjects/FindMyMainPage.swift
git add inspections/ui_20251004_100000.log
git commit -m "Update page objects for iOS 26.1 - tab labels changed"
```

## Quick Reference Commands

```bash
# Run inspection test
make test-device  # (add this to Makefile)

# Or full command
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests/FindMyUIInspectionTests \
  2>&1 | tee ui_inspection.log

# Extract just buttons
grep -A 200 "ALL BUTTONS:" ui_inspection.log | less

# Extract just tab info
grep -A 50 "TAB BARS:" ui_inspection.log

# Count elements
grep "Total.*found:" ui_inspection.log
```

## Troubleshooting

### Inspection Test Fails

**Issue**: Test doesn't run or fails immediately

**Solutions**:
1. Ensure device is unlocked
2. Check FindMy app is installed
3. Grant accessibility permissions
4. Verify device connection

### No Output Visible

**Issue**: Test runs but no output shown

**Solutions**:
1. Check log file: `cat ui_inspection.log`
2. In Xcode: Cmd+9 → Select test run → View console
3. Ensure test actually ran (check for "TEST SUCCEEDED")

### Wrong Elements Shown

**Issue**: Inspection shows different screen than expected

**Solutions**:
1. Ensure FindMy app is in correct state before test
2. Add navigation steps to inspection test
3. Take screenshot to verify what's displayed

## Integration with Development

### Continuous Inspection

Add to your workflow:

1. **Before major test runs** - Run inspection to verify UI
2. **After iOS updates** - Run inspection to catch changes
3. **When tests fail** - Run inspection to debug
4. **Weekly** - Run inspection to catch gradual changes

### Automated Checks

Create a script to detect changes:

```bash
#!/bin/bash
# check_ui_changes.sh

# Run inspection
xcodebuild test [...] 2>&1 | tee latest_inspection.log

# Compare with baseline
if diff baseline_inspection.log latest_inspection.log > /dev/null; then
    echo "✅ No UI changes detected"
else
    echo "⚠️  UI changes detected! Review latest_inspection.log"
    diff baseline_inspection.log latest_inspection.log
fi
```

## Files

- **Test Class**: `FindMeAppCTLTestUITests/FindMyUIInspectionTests.swift`
- **Page Objects**: `FindMeAppCTLTestUITests/PageObjects/FindMyMainPage.swift`
- **This Guide**: `docs/UI_INSPECTION_WORKFLOW.md`
- **UI Structure**: `docs/FINDMY_UI_STRUCTURE.md`

---

**Remember**: Always run inspection on an unlocked device with FindMy app accessible!
