# Device Tests Documentation

## Overview

The `TestDevice` class contains tests for device-specific functionality in the FindMy app, focusing on interactions with individual devices.

## Test Class: TestDevice

Located in: `tests/test_device.py`

### Test Methods

#### 1. `test_play_sound_on_chis_laptop`

**Purpose**: Test the Play Sound functionality on Chi's Laptop device.

**Test Flow**:
1. Launch FindMy app
2. Navigate to Devices tab
3. Find and tap on "Chi's Laptop" device
4. Verify device detail page is displayed
5. Verify device name contains "Chi's Laptop"
6. Tap Play Sound button
7. Wait for sound to play (5 seconds)
8. Close detail page

**Expected Results**:
- ✅ Devices tab is selected
- ✅ Chi's Laptop device is found and opened
- ✅ Device detail page displays correctly
- ✅ Play Sound button is tapped successfully
- ✅ Detail page closes properly

**Usage**:
```bash
pytest tests/test_device.py::TestDevice::test_play_sound_on_chis_laptop -v -s
```

#### 2. `test_view_chis_laptop_details`

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
pytest tests/test_device.py::TestDevice::test_view_chis_laptop_details -v -s
```

## Running Tests

### Run All Device Tests
```bash
cd python_prot
pytest tests/test_device.py -v -s
```

### Run Specific Test
```bash
cd python_prot
pytest tests/test_device.py::TestDevice::test_play_sound_on_chis_laptop -v -s
```

### Run with More Verbose Output
```bash
cd python_prot
pytest tests/test_device.py -vv -s --tb=short
```

## Prerequisites

1. **Appium Server**: Must be running on `http://127.0.0.1:4723`
   ```bash
   appium
   ```

2. **Device Connection**: iPhone must be connected and unlocked
   - Device UDID: `00008110-001E64343483801E`
   - Device Name: Chi Thu – iPhone

3. **FindMy App**: Must be installed and accessible on the device

4. **WebDriverAgent**: Must be configured and signed
   - Team ID: `5C489RHX7L`
   - Bundle ID: `com.chithule.WebDriverAgentRunner`

5. **Device Setup**: "Chi's Laptop" must be registered in FindMy app

## Page Objects Used

### FindMyMainPage
- `tap_devices_tab()`: Navigate to Devices tab
- `is_devices_tab_selected()`: Verify Devices tab is selected
- `tap_device_by_name(device_name)`: Find and tap device by name

### DeviceDetailPage
- `verify_detail_page_displayed()`: Verify detail page is shown
- `get_device_name()`: Get device name from page
- `tap_play_sound_button()`: Tap Play Sound button
- `is_map_visible()`: Check if map is visible
- `tap_close_button()`: Close detail page

## New Features Added

### 1. Enhanced FindMyMainPage
Added two new methods for finding devices/people by name:

```python
def tap_device_by_name(self, device_name):
    """Tap on a device by its name"""
    # Searches through all cells for matching device name
    # Case-insensitive search
    # Returns DeviceDetailPage instance

def tap_person_by_name(self, person_name):
    """Tap on a person by their name"""
    # Searches through all cells for matching person name
    # Case-insensitive search
    # Returns PeopleDetailPage instance
```

## Troubleshooting

### Device Not Found
If "Chi's Laptop" is not found:
1. Verify the device is registered in FindMy app
2. Check the device name spelling
3. Ensure you're on the Devices tab
4. Try listing all devices first:
   ```python
   main_page.tap_devices_tab()
   devices = main_page.get_all_device_names()
   print(devices)
   ```

### Play Sound Not Working
1. Ensure device is online and connected
2. Check device volume settings
3. Verify Play Sound feature is enabled for the device
4. Check FindMy app permissions

### Connection Issues
1. Verify Appium server is running
2. Check device is unlocked
3. Verify WebDriverAgent is properly signed
4. Check USB connection

## Future Enhancements

Potential additional tests:
- Test Directions button functionality
- Test Lost Mode activation
- Test device location accuracy
- Test multiple devices
- Test offline device handling
- Test device removal
- Test device notifications

## Related Documentation

- [README.md](README.md) - Main Python tests documentation
- [SETUP_WDA.md](SETUP_WDA.md) - WebDriverAgent setup guide
- [../docs/PAGE_OBJECTS_README.md](../docs/PAGE_OBJECTS_README.md) - Page Object pattern guide
