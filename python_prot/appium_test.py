#!/usr/bin/env python3
"""
Appium test script for FindMy app on iOS
"""

from appium import webdriver
from appium.options.ios import XCUITestOptions
from appium.webdriver.common.appiumby import AppiumBy
import time

# W3C compliant capabilities using XCUITestOptions
options = XCUITestOptions()

# Required capabilities
options.platform_name = 'iOS'
options.automation_name = 'XCUITest'
options.device_name = 'Chi Thu – iPhone'  # Your device name
options.udid = '00008110-001E64343483801E'  # Your device UDID

# FindMy app bundle identifier
options.bundle_id = 'com.apple.findmy'

# Additional options
options.no_reset = True  # Don't reset app state
options.new_command_timeout = 300  # 5 minutes timeout

# WebDriverAgent configuration for real device
options.show_xcode_log = True  # Show Xcode build logs for debugging
options.use_prebuilt_wda = True  # Use prebuilt WDA if available
options.xcode_org_id = '5C489RHX7L'  # Your Apple Developer Team ID
options.xcode_signing_id = 'Apple Development'  # Signing identity
options.updated_wda_bundle_id = 'com.chithule.WebDriverAgentRunner'  # Unique bundle ID

# Connect to Appium server
appium_server_url = 'http://127.0.0.1:4723'

def test_findmy_app():
    """Test FindMy app basic functionality"""
    
    driver = webdriver.Remote(appium_server_url, options=options)
    
    try:
        print("✅ Connected to FindMy app")
        
        # Wait for app to load
        time.sleep(3)
        
        # Print page source to inspect elements
        print("\n📱 App UI Structure:")
        print(driver.page_source)
        
        # Example: Find and tap on People tab
        try:
            people_tab = driver.find_element(AppiumBy.ACCESSIBILITY_ID, "People")
            people_tab.click()
            print("✅ Tapped People tab")
            time.sleep(2)
        except Exception as e:
            print(f"⚠️ Could not find People tab: {e}")
        
        # Example: Find and tap on Devices tab
        try:
            devices_tab = driver.find_element(AppiumBy.ACCESSIBILITY_ID, "Devices")
            devices_tab.click()
            print("✅ Tapped Devices tab")
            time.sleep(2)
        except Exception as e:
            print(f"⚠️ Could not find Devices tab: {e}")
        
        # Take screenshot
        screenshot_path = "./screenshots/appium_screenshot.png"
        driver.save_screenshot(screenshot_path)
        print(f"📸 Screenshot saved to: {screenshot_path}")
        
    except Exception as e:
        print(f"❌ Error during test: {e}")
    
    finally:
        # Close the session
        driver.quit()
        print("✅ Test completed")

if __name__ == "__main__":
    test_findmy_app()
