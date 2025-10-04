# Device Tests Documentation

## Overview

Device tests verify functionality related to individual devices in the FindMy app, including Play Sound, Directions, location information, and other device-specific features.

## Swift Tests (XCUITest)

### Test Class: `DeviceTests`

Located in: `FindMeAppCTLTestUITests/DeviceTests.swift`

#### Test Methods

##### 1. `testPlaySoundOnChisLaptop`

**Purpose**: Test the Play Sound functionality on Chi's Laptop device.

**Test Flow**:
1. Launch FindMy app
2. Verify main page is displayed
3. Navigate to Devices tab
4. Find and tap on "Chi's Laptop" device (case-insensitive search)
5. Verify device detail page is displayed
6. Verify device name contains "Chi" and "Laptop"
7. Verify Play Sound button is visible
8. Tap Play Sound button
9. Wait 5 seconds for sound to play
10. Take screenshot
11. Close detail page

**Expected Results**:
- ✅ Devices tab is selected
- ✅ Chi's Laptop device is found and opened
- ✅ Device detail page displays correctly
- ✅ Device name matches expected pattern
- ✅ Play Sound button is visible and tappable
- ✅ Detail page closes properly

**Usage**:
```bash
# Run in Xcode or via command line
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests/DeviceTests/testPlaySoundOnChisLaptop
```

##### 2. `testViewChisLaptopDetails`

**Purpose**: Test viewing Chi's Laptop device details and verifying all UI elements.

**Test Flow**:
1. Launch FindMy app
2. Navigate to Devices tab
3. Find and tap on "Chi's Laptop"
4. Verify detail page is displayed
5. Get and print device name
6. Verify map is visible
7. Verify all action buttons are visible (Play Sound, Directions, Mark As Lost)
8. Take screenshot
9. Close detail page

**Expected Results**:
- ✅ All UI elements are visible
- ✅ Device information is displayed correctly
- ✅ Action buttons are accessible

##### 3. `testChisLaptopDirections`

**Purpose**: Test the Directions functionality for Chi's Laptop.

**Test Flow**:
1. Launch FindMy app
2. Navigate to Devices tab
3. Find and tap on "Chi's Laptop"
4. Verify Directions button is visible and enabled
5. Tap Directions button
6. Wait for Maps integration
7. Take screenshot

**Expected Results**:
- ✅ Directions button is enabled
- ✅ Directions action is triggered

##### 4. `testChisLaptopLocationInfo`

**Purpose**: Test retrieving and verifying location information for Chi's Laptop.

**Test Flow**:
1. Launch FindMy app
2. Navigate to Devices tab
3. Find and tap on "Chi's Laptop"
4. Get device name, location, and last seen information
5. Verify all information is not empty
6. Verify map is displayed
7. Take screenshot

**Expected Results**:
- ✅ Device name is retrieved
- ✅ Location text is not empty
- ✅ Last seen text is not empty
- ✅ Map is displayed

##### 5. `testNavigateToDevicesAndViewFirst`

**Purpose**: General test for navigating to Devices tab and viewing the first device.

**Test Flow**:
1. Launch FindMy app
2. Navigate to Devices tab
3. Verify list is displayed
4. Count devices in list
5. Tap first device
6. Verify detail page
7. Get device name
8. Take screenshot

**Expected Results**:
- ✅ At least one device exists
- ✅ First device can be opened
- ✅ Detail page displays correctly

### Running Swift Tests

#### Run All Device Tests
```bash
# Using Make
make test-device

# Using xcodebuild
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests/DeviceTests
```

#### Run Specific Test
```bash
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests/DeviceTests/testPlaySoundOnChisLaptop
```

#### Run in Xcode
1. Open `FindMeAppCTLTest.xcodeproj`
2. Select your device from the device dropdown
3. Open `DeviceTests.swift`
4. Click the diamond icon next to the test method
5. Or use Test Navigator (⌘6) → DeviceTests → Select test

---

## Python Tests (Appium)

### Test Class: `TestDevice`

Located in: `python_prot/tests/test_device.py`

#### Test Methods

##### 1. `test_play_sound_on_chis_laptop`

**Purpose**: Test the Play Sound functionality on Chi's Laptop device.

**Test Flow**:
1. Launch FindMy app
2. Navigate to Devices tab
3. Find and tap on "Chi's Laptop" device
4. Verify device detail page is displayed
5. Verify device name contains "chi" and "laptop"
6. Tap Play Sound button
7. Wait 5 seconds for sound to play
8. Close detail page

**Expected Results**:
- ✅ Devices tab is selected
- ✅ Chi's Laptop device is found and opened
- ✅ Device detail page displays correctly
- ✅ Play Sound button is tapped successfully
- ✅ Detail page closes properly

**Usage**:
```bash
cd python_prot
pytest tests/test_device.py::TestDevice::test_play_sound_on_chis_laptop -v -s
```

##### 2. `test_view_chis_laptop_details`

**Purpose**: Test viewing Chi's Laptop device details.

**Test Flow**:
1. Launch FindMy app
2. Navigate to Devices tab
3. Find and tap on "Chi's Laptop" device
4. Verify device detail page is displayed
5. Get and print device name
6. Verify map is visible
7. Close detail page

**Expected Results**:
- ✅ Device detail page displays correctly
- ✅ Device name is retrieved
- ✅ Map is visible on detail page
- ✅ Detail page closes properly

**Usage**:
```bash
cd python_prot
pytest tests/test_device.py::TestDevice::test_view_chis_laptop_details -v -s
```

### Running Python Tests

#### Run All Device Tests
```bash
cd python_prot
pytest tests/test_device.py -v -s
```

#### Run Specific Test
```bash
cd python_prot
pytest tests/test_device.py::TestDevice::test_play_sound_on_chis_laptop -v -s
```

---

## New Page Object Features

### FindMyMainPage Enhancements

Both Swift and Python implementations now include methods to find devices/people/items by name:

#### Swift
```swift
func tapDeviceByName(_ deviceName: String) -> DeviceDetailPage
func tapPersonByName(_ personName: String) -> PeopleDetailPage
func tapItemByName(_ itemName: String) -> ItemDetailPage
```

#### Python
```python
def tap_device_by_name(self, device_name) -> DeviceDetailPage
def tap_person_by_name(self, person_name) -> PeopleDetailPage
```

**Features**:
- Case-insensitive search
- Partial name matching
- Returns appropriate detail page object
- Fails with descriptive error if not found

---

## Prerequisites

### Swift Tests
1. **Xcode**: Latest version with XCUITest support
2. **Device**: iPhone connected and unlocked
   - Device UDID: `00008110-001E64343483801E`
   - Device Name: Chi Thu – iPhone
3. **FindMy App**: Installed on device
4. **Device Setup**: "Chi's Laptop" must be registered in FindMy

### Python Tests
1. **Appium Server**: Running on `http://127.0.0.1:4723`
2. **Device**: Same as Swift tests
3. **WebDriverAgent**: Configured and signed
   - Team ID: `5C489RHX7L`
   - Bundle ID: `com.chithule.WebDriverAgentRunner`
4. **Python Dependencies**: Installed via `pip install -r requirements.txt`

---

## Page Objects Used

### FindMyMainPage
- `navigateToDevicesTab()` / `tap_devices_tab()`: Navigate to Devices tab
- `verifyDevicesTabIsSelected()` / `is_devices_tab_selected()`: Verify tab selection
- `tapDeviceByName()` / `tap_device_by_name()`: Find and tap device by name
- `getListItemCount()` / `get_all_device_names()`: Get device information

### DeviceDetailPage
- `verifyDetailPageIsDisplayed()` / `verify_detail_page_displayed()`: Verify page
- `getDeviceName()` / `get_device_name()`: Get device name
- `playSound()` / `tap_play_sound_button()`: Tap Play Sound
- `getDirections()` / `tap_directions_button()`: Tap Directions
- `verifyMapIsDisplayed()` / `is_map_visible()`: Verify map
- `tapCloseButton()` / `tap_close_button()`: Close page

---

## Troubleshooting

### Device Not Found
If "Chi's Laptop" is not found:
1. Verify the device is registered in FindMy app
2. Check the device name spelling in FindMy
3. Ensure you're on the Devices tab
4. Try listing all devices first to see available names

### Play Sound Not Working
1. Ensure device is online and connected to internet
2. Check device volume settings
3. Verify Play Sound feature is enabled for the device
4. Check FindMy app permissions on both devices

### Swift Test Issues
1. Clean build folder (⌘⇧K in Xcode)
2. Verify device is selected in Xcode
3. Check device is unlocked and trusted
4. Verify code signing is correct

### Python Test Issues
1. Verify Appium server is running
2. Check WebDriverAgent is properly signed
3. Ensure device is unlocked
4. Check USB connection

---

## Future Enhancements

Potential additional tests:
- Test Lost Mode activation and deactivation
- Test device location accuracy
- Test multiple devices simultaneously
- Test offline device handling
- Test device removal workflow
- Test device notifications
- Test Erase Device functionality (with caution!)
- Test device battery status display
- Test device network status

---

## Related Documentation

- [UI_TESTS_README.md](UI_TESTS_README.md) - Main UI tests documentation
- [PAGE_OBJECTS_README.md](PAGE_OBJECTS_README.md) - Page Object pattern guide
- [RUN_ON_DEVICE.md](RUN_ON_DEVICE.md) - Device testing setup
- [../python_prot/README.md](../python_prot/README.md) - Python tests documentation
- [../python_prot/DEVICE_TESTS.md](../python_prot/DEVICE_TESTS.md) - Python device tests
