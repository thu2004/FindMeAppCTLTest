# Device Tests Quick Start

Quick reference for running device tests on Chi's Laptop.

## Swift Tests (XCUITest)

### Run All Device Tests
```bash
# Using Make
make test-device

# Or with xcodebuild
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests/DeviceTests
```

### Run Play Sound Test
```bash
xcodebuild test \
  -project FindMeAppCTLTest.xcodeproj \
  -scheme FindMeAppCTLTest \
  -destination 'platform=iOS,id=00008110-001E64343483801E' \
  -only-testing:FindMeAppCTLTestUITests/DeviceTests/testPlaySoundOnChisLaptop
```

### Run in Xcode
1. Open `FindMeAppCTLTest.xcodeproj`
2. Select your device: Chi Thu – iPhone
3. Open `DeviceTests.swift`
4. Click ◇ next to `testPlaySoundOnChisLaptop`

---

## Python Tests (Appium)

### Prerequisites
```bash
# Start Appium server (in separate terminal)
appium

# Ensure device is connected
xcrun xctrace list devices
```

### Run All Device Tests
```bash
cd python_prot
pytest tests/test_device.py -v -s
```

### Run Play Sound Test
```bash
cd python_prot
pytest tests/test_device.py::TestDevice::test_play_sound_on_chis_laptop -v -s
```

---

## Available Tests

### Swift (DeviceTests.swift)
- ✅ `testPlaySoundOnChisLaptop` - Play sound on Chi's Laptop
- ✅ `testViewChisLaptopDetails` - View device details
- ✅ `testChisLaptopDirections` - Test directions feature
- ✅ `testChisLaptopLocationInfo` - Get location information
- ✅ `testNavigateToDevicesAndViewFirst` - General device navigation

### Python (test_device.py)
- ✅ `test_play_sound_on_chis_laptop` - Play sound on Chi's Laptop
- ✅ `test_view_chis_laptop_details` - View device details

---

## What the Tests Do

### Play Sound Test
1. Opens FindMy app
2. Goes to Devices tab
3. Finds "Chi's Laptop" by name
4. Opens device details
5. Taps "Play Sound" button
6. Waits 5 seconds for sound
7. Closes detail page

**Expected**: Chi's Laptop should play a sound

---

## Troubleshooting

### "Device not found"
- Check device name in FindMy app
- Ensure device is registered
- Verify you're on Devices tab

### "Appium connection error" (Python)
```bash
# Start Appium server
appium
```

### "Build failed" (Swift)
- Clean build: ⌘⇧K in Xcode
- Verify device is selected
- Check device is unlocked

---

## Full Documentation

See [docs/DEVICE_TESTS.md](docs/DEVICE_TESTS.md) for complete documentation.
