# UI Inspection Workflow - Quick Summary

## ✅ Setup Complete

The `FindMyUIInspectionTests` class is now your tool for capturing and updating FindMy app UI structure.

## Quick Usage

### Run UI Inspection

```bash
# Easiest way (saves to inspections/ folder with timestamp)
make inspect-ui

# Or manually
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests/FindMyUIInspectionTests \
  2>&1 | tee ui_inspection.log
```

**Important**: Device must be unlocked!

### Review Results

```bash
# View latest inspection
ls -lt inspections/ | head -2

# View specific inspection
cat inspections/ui_inspection_20251004_100000.log | less

# Extract just buttons
grep -A 100 "ALL BUTTONS:" inspections/ui_inspection_*.log | less
```

## When to Run

- ✅ **Before updating page objects** - See current UI structure
- ✅ **After iOS updates** - Detect UI changes
- ✅ **When tests fail** - Debug element issues
- ✅ **New device/language** - Verify localized labels
- ✅ **Weekly** - Catch gradual changes

## Update Workflow

### 1. Run Inspection
```bash
make inspect-ui
```

### 2. Review Output
Look for tab button labels:
```
Button 3: Label: 'People'
Button 4: Label: 'Devices'
Button 5: Label: 'Items'
Button 6: Label: 'Me'
```

### 3. Update Page Objects
If labels changed, update `FindMyMainPage.swift`:

```swift
private struct Identifiers {
    static let peopleTab = "People"    // Update if changed
    static let devicesTab = "Devices"  // Update if changed
    static let itemsTab = "Items"      // Update if changed
    static let meTab = "Me"            // Update if changed
}
```

### 4. Verify
```bash
make build
make test-device-tabs
```

## Current Configuration

### Latest Inspection Results (2025-10-04)

**Tab Buttons (English):**
- Button 3: "People" (not selected)
- Button 4: "Devices" (not selected)
- Button 5: "Items" (not selected)
- Button 6: "Me" (selected)

**Other Buttons:**
- Button 0: "Map Modes"
- Button 1: "Tracking" (disabled)
- Button 2: "add" (identifier: `FindMyBaseViewAddAction`)

**Page Objects Status:** ✅ Up to date with English labels

## Files

- **Test Class**: `FindMeAppCTLTestUITests/FindMyUIInspectionTests.swift`
- **Page Objects**: `FindMeAppCTLTestUITests/PageObjects/FindMyMainPage.swift`
- **Workflow Guide**: `docs/UI_INSPECTION_WORKFLOW.md`
- **Inspections Folder**: `inspections/` (auto-created)

## Quick Commands

```bash
# Run inspection
make inspect-ui

# View help
make help

# Compare two inspections
diff inspections/ui_inspection_A.log inspections/ui_inspection_B.log

# Extract buttons only
grep -A 100 "ALL BUTTONS:" inspections/latest.log
```

## Tips

1. **Save baselines** - Keep a baseline inspection for comparison
2. **Document changes** - Note why identifiers changed in code comments
3. **Version control** - Commit inspection logs with page object updates
4. **Regular checks** - Run weekly to catch gradual UI changes

---

**Remember**: Always unlock your device before running inspection!
