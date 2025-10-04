# Running Individual Tests

## Best Method: Use Xcode (Most Reliable)

### Step 1: Open Project in Xcode Beta
```bash
open -a "Xcode-beta" FindMeAppCTLTest.xcodeproj
```

### Step 2: Select Your Device
- Click the device selector in the toolbar
- Choose **"Chi Thu – iPhone (180)"**

### Step 3: Unlock Your iPhone
⚠️ **Critical**: Keep your iPhone unlocked during test execution

### Step 4: Run Individual Test

#### Method A: Click Diamond Icon
1. Open `FindMeAppCTLTestUITests.swift`
2. Find the test you want to run (e.g., `testNavigateThroughAllTabs`)
3. Click the **diamond icon** (▶️) next to the test method
4. Test will run on your device

#### Method B: Right-Click Menu
1. Right-click on the test method name
2. Select **"Run 'testNavigateThroughAllTabs()'"**

#### Method C: Keyboard Shortcut
1. Place cursor inside the test method
2. Press **`Ctrl+Option+Cmd+U`**

### Step 5: View Results
- Results appear in the **Test Navigator** (`Cmd+6`)
- Console output in **Report Navigator** (`Cmd+9`)
- Green checkmark ✅ = Passed
- Red X ❌ = Failed

## Available Individual Tests

### Navigation Tests

#### 1. testExample
**Purpose**: Basic example test
**Duration**: ~12 seconds
**What it does**: Launches app, navigates to Devices tab

#### 2. testNavigateThroughAllTabs (FIXED)
**Purpose**: Complete tab navigation cycle
**Duration**: ~40 seconds
**What it does**: 
- Navigates: People → Devices → Items → Me → People
- Takes screenshots of each tab
- Waits 5 seconds on each tab

#### 3. testTabNavigationSequence
**Purpose**: Quick navigation with method chaining
**Duration**: ~30 seconds
**What it does**: Tests Devices → Items → Me tabs

### Individual Tab Tests

#### 4. testIndividualTabDevices
**Purpose**: Test Devices tab only
**Duration**: ~17 seconds

#### 5. testIndividualTabItems
**Purpose**: Test Items tab only
**Duration**: ~17 seconds

#### 6. testIndividualTabMe
**Purpose**: Test Me tab only
**Duration**: ~17 seconds

### Performance & Inspection

#### 7. testLaunchPerformance
**Purpose**: Measure app launch time
**Duration**: ~21 seconds

#### 8. testInspectFindMyAppUI (in FindMyUIInspectionTests)
**Purpose**: Inspect UI structure
**Duration**: ~23 seconds
**File**: `FindMyUIInspectionTests.swift`

## Running Multiple Tests

### Run All Tests in a Class
1. Open the test file
2. Click the diamond icon next to the **class name**
3. Or press `Cmd+U` to run all tests

### Run Specific Tests
Hold `Cmd` and click multiple diamond icons to select tests, then run

## Troubleshooting

### Test Doesn't Start
**Solution**: 
- Ensure device is unlocked
- Check device is selected in Xcode
- Try: Product → Clean Build Folder (`Cmd+Shift+K`)

### Test Fails Immediately
**Solution**:
- Check console output for errors
- Verify FindMy app is installed
- Grant accessibility permissions if prompted

### Can't See Test Results
**Solution**:
- Open Report Navigator: `Cmd+9`
- Select the latest test run
- Click on the test to see details

## Command Line (Alternative)

If you must use command line, run tests one at a time:

### Single Test
```bash
# Unlock device first!
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests/testNavigateThroughAllTabs
```

### Different Tests
```bash
# Test Devices tab
xcodebuild test [...] -only-testing:FindMeAppCTLTestUITests/testIndividualTabDevices

# Test Items tab
xcodebuild test [...] -only-testing:FindMeAppCTLTestUITests/testIndividualTabItems

# Test Me tab
xcodebuild test [...] -only-testing:FindMeAppCTLTestUITests/testIndividualTabMe

# UI Inspection
xcodebuild test [...] -only-testing:FindMeAppCTLTestUITests/FindMyUIInspectionTests
```

## Tips for Success

### 1. Keep Device Unlocked
- Most important factor for test success
- Tests will fail if device locks mid-execution

### 2. Use Xcode for Individual Tests
- More reliable than command line
- Better visual feedback
- Easier to debug

### 3. Check Test Duration
- Short tests (~12-17s): Run individually
- Long tests (~40s): Ensure device stays unlocked

### 4. View Screenshots
- Screenshots saved in test results
- Access via Report Navigator → Attachments

### 5. Debug Failed Tests
- Check console output first
- Run UI inspection if elements not found
- Verify page object identifiers match app

## Quick Reference

| Test | Command | Duration |
|------|---------|----------|
| Example | `testExample` | 12s |
| All Tabs | `testNavigateThroughAllTabs` | 40s |
| Tab Sequence | `testTabNavigationSequence` | 30s |
| Devices Tab | `testIndividualTabDevices` | 17s |
| Items Tab | `testIndividualTabItems` | 17s |
| Me Tab | `testIndividualTabMe` | 17s |
| Performance | `testLaunchPerformance` | 21s |
| UI Inspection | `testInspectFindMyAppUI` | 23s |

---

**Recommended**: Use Xcode for running individual tests - it's more reliable and provides better feedback!
