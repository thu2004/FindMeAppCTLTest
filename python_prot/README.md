# FindMy App - Python Appium Tests

Python-based Appium automation tests for the FindMy iOS app.

## Setup

### 1. Install Python Dependencies

```bash
cd python_prot
pip install -r requirements.txt
```

### 2. Start Appium Server

Make sure Appium server is running:

```bash
appium
```

The server should be running on `http://127.0.0.1:4723`

### 3. Connect Your iPhone

- Connect your iPhone via USB
- Ensure the device is unlocked and trusted
- Device UDID: `00008110-001E64343483801E`

## Project Structure

```
python_prot/
├── README.md                    # This file
├── requirements.txt             # Python dependencies
├── appium_test.py              # Simple standalone test
├── page_objects/               # Page Object Model
│   ├── __init__.py
│   ├── base_page.py           # Base page with common methods
│   ├── findmy_main_page.py    # Main page object
│   ├── people_detail_page.py  # People detail page
│   └── device_detail_page.py  # Device detail page
└── tests/                      # Test cases
    ├── __init__.py
    └── test_findmy_navigation.py  # Navigation tests
```

## Running Tests

### Run Simple Test

```bash
cd python_prot
python appium_test.py
```

### Run All Tests with Pytest

```bash
cd python_prot
pytest tests/ -v -s
```

### Run Specific Test

```bash
cd python_prot
pytest tests/test_findmy_navigation.py::test_navigate_to_people_tab -v -s
```

## Configuration

Update device settings in test files if needed:

```python
options.device_name = 'Chi Thu – iPhone'
options.udid = '00008110-001E64343483801E'
options.bundle_id = 'com.apple.findmy'
```

## Page Objects

The tests use the Page Object Model pattern:

- **BasePage**: Common methods (find_element, tap, wait, etc.)
- **FindMyMainPage**: Main screen with tabs (People, Devices, Items, Me)
- **PeopleDetailPage**: Person detail screen
- **DeviceDetailPage**: Device detail screen

## Test Cases

- `test_navigate_to_people_tab`: Navigate to People tab
- `test_navigate_to_devices_tab`: Navigate to Devices tab
- `test_navigate_to_items_tab`: Navigate to Items tab
- `test_navigate_to_me_tab`: Navigate to Me tab
- `test_view_person_details`: View person details
- `test_view_device_details`: View device details

## Troubleshooting

### Capabilities Error
If you see "Invalid or unsupported WebDriver capabilities", ensure you're using W3C compliant capabilities with `XCUITestOptions`.

### Connection Error
- Verify Appium server is running on port 4723
- Check device is connected and unlocked
- Verify UDID is correct: `xcrun xctrace list devices`

### Element Not Found
- Check element identifiers in page objects
- Use Appium Inspector to verify element attributes
- Increase wait timeouts if needed

## Dependencies

- `Appium-Python-Client>=3.1.0`: Appium Python client
- `selenium>=4.15.0`: WebDriver support
- `pytest`: Test framework (optional, for running test suite)
