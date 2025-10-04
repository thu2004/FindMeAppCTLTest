"""
Device Detail Page Object
"""

from appium.webdriver.common.appiumby import AppiumBy
from .base_page import BasePage


class DeviceDetailPage(BasePage):
    """Page object for Device detail screen"""
    
    # Element identifiers
    CLOSE_BUTTON = "Close"
    PLAY_SOUND_BUTTON = "Play Sound,Off"
    DIRECTIONS_BUTTON = "Directions,"
    LOST_MODE_BUTTON = "Lost Mode, Enable additional protection, Off"
    
    def __init__(self, driver):
        super().__init__(driver)
    
    def tap_close_button(self):
        """Close the detail page"""
        from .findmy_main_page import FindMyMainPage
        close_btn = self.find_element_by_accessibility_id(self.CLOSE_BUTTON)
        self.tap(close_btn)
        print("✅ Closed Device detail page")
        return FindMyMainPage(self.driver)
    
    def tap_play_sound_button(self):
        """Tap play sound button"""
        play_sound_btn = self.find_element_by_accessibility_id(self.PLAY_SOUND_BUTTON)
        self.tap(play_sound_btn)
        print("✅ Tapped Play Sound button")
        return self
    
    def tap_directions_button(self):
        """Tap directions button"""
        directions_btn = self.find_element_by_accessibility_id(self.DIRECTIONS_BUTTON)
        self.tap(directions_btn)
        print("✅ Tapped Directions button")
        return self
    
    def tap_lost_mode_button(self):
        """Tap lost mode button"""
        lost_mode_btn = self.find_element_by_accessibility_id(self.LOST_MODE_BUTTON)
        self.tap(lost_mode_btn)
        print("✅ Tapped Lost Mode button")
        return self
    
    def get_device_name(self):
        """Get device name from the page"""
        # Find the primary label (device name)
        name_element = self.find_element_by_accessibility_id("PrimaryLabel")
        return self.get_text(name_element)
    
    def is_map_visible(self):
        """Check if map is visible"""
        return self.is_element_visible(AppiumBy.CLASS_NAME, "XCUIElementTypeMap")
    
    def verify_detail_page_displayed(self):
        """Verify the detail page is displayed"""
        assert self.is_map_visible(), "Map should be visible on detail page"
        print("✅ Device detail page is displayed")
        return self
