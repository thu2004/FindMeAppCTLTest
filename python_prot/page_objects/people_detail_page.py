"""
People Detail Page Object
"""

from appium.webdriver.common.appiumby import AppiumBy
from .base_page import BasePage


class PeopleDetailPage(BasePage):
    """Page object for People detail screen"""
    
    # Element identifiers
    CLOSE_BUTTON = "Close"
    CONTACT_BUTTON = "Contact,Info"
    DIRECTIONS_BUTTON = "Directions, "
    
    def __init__(self, driver):
        super().__init__(driver)
    
    def tap_close_button(self):
        """Close the detail page"""
        from .findmy_main_page import FindMyMainPage
        close_btn = self.find_element_by_accessibility_id(self.CLOSE_BUTTON)
        self.tap(close_btn)
        print("✅ Closed People detail page")
        return FindMyMainPage(self.driver)
    
    def tap_contact_button(self):
        """Tap contact button"""
        contact_btn = self.find_element_by_accessibility_id(self.CONTACT_BUTTON)
        self.tap(contact_btn)
        print("✅ Tapped Contact button")
        return self
    
    def tap_directions_button(self):
        """Tap directions button"""
        directions_btn = self.find_element_by_accessibility_id(self.DIRECTIONS_BUTTON)
        self.tap(directions_btn)
        print("✅ Tapped Directions button")
        return self
    
    def get_person_name(self):
        """Get person's name from the page"""
        # Find the primary label (person name)
        name_element = self.find_element_by_accessibility_id("PrimaryLabel")
        return self.get_text(name_element)
    
    def is_map_visible(self):
        """Check if map is visible"""
        return self.is_element_visible(AppiumBy.CLASS_NAME, "XCUIElementTypeMap")
    
    def verify_detail_page_displayed(self):
        """Verify the detail page is displayed"""
        assert self.is_map_visible(), "Map should be visible on detail page"
        print("✅ People detail page is displayed")
        return self
