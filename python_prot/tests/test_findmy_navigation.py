#!/usr/bin/env python3
"""
Test FindMy app navigation
"""

import pytest
import time
from appium import webdriver
from appium.options.ios import XCUITestOptions
from page_objects import FindMyMainPage


@pytest.fixture(scope="function")
def driver():
    """Setup and teardown Appium driver"""
    
    # W3C compliant capabilities
    options = XCUITestOptions()
    options.platform_name = 'iOS'
    options.automation_name = 'XCUITest'
    options.device_name = 'Chi Thu – iPhone'
    options.udid = '00008110-001E64343483801E'
    options.bundle_id = 'com.apple.findmy'
    options.no_reset = True
    options.new_command_timeout = 300
    
    # WebDriverAgent configuration
    options.show_xcode_log = True
    options.use_prebuilt_wda = True
    options.xcode_org_id = '5C489RHX7L'
    options.xcode_signing_id = 'Apple Development'
    options.updated_wda_bundle_id = 'com.chithule.WebDriverAgentRunner'
    
    # Connect to Appium server
    appium_server_url = 'http://127.0.0.1:4723'
    driver = webdriver.Remote(appium_server_url, options=options)
    
    yield driver
    
    # Teardown
    driver.quit()


def test_navigate_to_people_tab(driver):
    """Test navigation to People tab"""
    main_page = FindMyMainPage(driver)
    time.sleep(2)  # Wait for app to load
    
    main_page.tap_people_tab()
    time.sleep(1)
    
    assert main_page.is_people_tab_selected(), "People tab should be selected"
    print("✅ Successfully navigated to People tab")


def test_navigate_to_devices_tab(driver):
    """Test navigation to Devices tab"""
    main_page = FindMyMainPage(driver)
    time.sleep(2)
    
    main_page.tap_devices_tab()
    time.sleep(1)
    
    assert main_page.is_devices_tab_selected(), "Devices tab should be selected"
    print("✅ Successfully navigated to Devices tab")


def test_navigate_to_items_tab(driver):
    """Test navigation to Items tab"""
    main_page = FindMyMainPage(driver)
    time.sleep(2)
    
    main_page.tap_items_tab()
    time.sleep(1)
    
    print("✅ Successfully navigated to Items tab")


def test_navigate_to_me_tab(driver):
    """Test navigation to Me tab"""
    main_page = FindMyMainPage(driver)
    time.sleep(2)
    
    main_page.tap_me_tab()
    time.sleep(1)
    
    print("✅ Successfully navigated to Me tab")


def test_view_person_details(driver):
    """Test viewing person details"""
    main_page = FindMyMainPage(driver)
    time.sleep(2)
    
    # Navigate to People tab
    main_page.tap_people_tab()
    time.sleep(1)
    
    # Tap first person
    detail_page = main_page.tap_first_person()
    time.sleep(2)
    
    # Verify detail page
    detail_page.verify_detail_page_displayed()
    
    # Get person name
    name = detail_page.get_person_name()
    print(f"📝 Person name: {name}")
    
    # Close detail page
    detail_page.tap_close_button()
    time.sleep(1)
    
    print("✅ Successfully viewed person details")


def test_view_device_details(driver):
    """Test viewing device details"""
    main_page = FindMyMainPage(driver)
    time.sleep(2)
    
    # Navigate to Devices tab
    main_page.tap_devices_tab()
    time.sleep(1)
    
    # Tap first device
    detail_page = main_page.tap_first_device()
    time.sleep(2)
    
    # Verify detail page
    detail_page.verify_detail_page_displayed()
    
    # Get device name
    name = detail_page.get_device_name()
    print(f"📝 Device name: {name}")
    
    # Close detail page
    detail_page.tap_close_button()
    time.sleep(1)
    
    print("✅ Successfully viewed device details")


if __name__ == "__main__":
    pytest.main([__file__, "-v", "-s"])
