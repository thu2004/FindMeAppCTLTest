#!/usr/bin/env python3
"""
Test FindMy app device functionality
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


class TestDevice:
    """Test class for device-related functionality"""
    
    def test_play_sound_on_chis_laptop(self, driver):
        """Test playing sound on Chi's Laptop device"""
        print("\n🔊 Testing Play Sound on Chi's Laptop...")
        
        # Initialize main page
        main_page = FindMyMainPage(driver)
        time.sleep(2)  # Wait for app to load
        
        # Navigate to Devices tab
        print("📱 Navigating to Devices tab...")
        main_page.tap_devices_tab()
        time.sleep(2)  # Wait for devices to load
        
        # Verify we're on Devices tab
        assert main_page.is_devices_tab_selected(), "Devices tab should be selected"
        print("✅ On Devices tab")
        
        # Find and tap on Chi's Laptop
        print("🔍 Looking for Chi's Laptop...")
        device_detail_page = main_page.tap_device_by_name("Chi's Laptop")
        time.sleep(3)  # Wait for detail page to load
        
        # Verify detail page is displayed
        device_detail_page.verify_detail_page_displayed()
        
        # Get and verify device name
        device_name = device_detail_page.get_device_name()
        print(f"📝 Device name: {device_name}")
        assert "chi" in device_name.lower() and "laptop" in device_name.lower(), \
            f"Expected device name to contain 'Chi's Laptop', got: {device_name}"
        
        # Tap Play Sound button
        print("🔊 Tapping Play Sound button...")
        device_detail_page.tap_play_sound_button()
        time.sleep(2)  # Wait for sound to start playing
        
        print("✅ Play Sound button tapped successfully")
        print("⏱️  Waiting 5 seconds for sound to play...")
        time.sleep(5)
        
        # Close detail page
        print("⬅️  Closing detail page...")
        device_detail_page.tap_close_button()
        time.sleep(1)
        
        print("✅ Test completed successfully: Play Sound on Chi's Laptop")
    
    def test_view_chis_laptop_details(self, driver):
        """Test viewing Chi's Laptop device details"""
        print("\n📋 Testing Chi's Laptop details view...")
        
        # Initialize main page
        main_page = FindMyMainPage(driver)
        time.sleep(2)
        
        # Navigate to Devices tab
        main_page.tap_devices_tab()
        time.sleep(2)
        
        # Find and tap on Chi's Laptop
        device_detail_page = main_page.tap_device_by_name("Chi's Laptop")
        time.sleep(3)
        
        # Verify detail page
        device_detail_page.verify_detail_page_displayed()
        
        # Get device information
        device_name = device_detail_page.get_device_name()
        print(f"📝 Device name: {device_name}")
        
        # Verify map is visible
        assert device_detail_page.is_map_visible(), "Map should be visible"
        print("✅ Map is visible")
        
        # Close detail page
        device_detail_page.tap_close_button()
        time.sleep(1)
        
        print("✅ Test completed successfully: Chi's Laptop details view")


if __name__ == "__main__":
    pytest.main([__file__, "-v", "-s"])
