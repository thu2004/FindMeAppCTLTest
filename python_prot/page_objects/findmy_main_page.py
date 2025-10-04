"""
FindMy Main Page Object
"""

from appium.webdriver.common.appiumby import AppiumBy
from .base_page import BasePage


class FindMyMainPage(BasePage):
    """Page object for FindMy app main screen"""
    
    # Tab identifiers
    PEOPLE_TAB = "People"
    DEVICES_TAB = "Devices"
    ITEMS_TAB = "Items"
    ME_TAB = "Me"
    
    def __init__(self, driver):
        super().__init__(driver)
    
    def tap_people_tab(self):
        """Navigate to People tab"""
        people_tab = self.find_element_by_accessibility_id(self.PEOPLE_TAB)
        self.tap(people_tab)
        print("✅ Tapped People tab")
        return self
    
    def tap_devices_tab(self):
        """Navigate to Devices tab"""
        devices_tab = self.find_element_by_accessibility_id(self.DEVICES_TAB)
        self.tap(devices_tab)
        print("✅ Tapped Devices tab")
        return self
    
    def tap_items_tab(self):
        """Navigate to Items tab"""
        items_tab = self.find_element_by_accessibility_id(self.ITEMS_TAB)
        self.tap(items_tab)
        print("✅ Tapped Items tab")
        return self
    
    def tap_me_tab(self):
        """Navigate to Me tab"""
        me_tab = self.find_element_by_accessibility_id(self.ME_TAB)
        self.tap(me_tab)
        print("✅ Tapped Me tab")
        return self
    
    def is_people_tab_selected(self):
        """Check if People tab is selected"""
        people_tab = self.find_element_by_accessibility_id(self.PEOPLE_TAB)
        return people_tab.get_attribute("selected") == "true"
    
    def is_devices_tab_selected(self):
        """Check if Devices tab is selected"""
        devices_tab = self.find_element_by_accessibility_id(self.DEVICES_TAB)
        return devices_tab.get_attribute("selected") == "true"
    
    def tap_first_person(self):
        """Tap on first person in the list"""
        from .people_detail_page import PeopleDetailPage
        # Find first cell in table
        first_cell = self.find_element_by_xpath("//XCUIElementTypeTable/XCUIElementTypeCell[1]")
        self.tap(first_cell)
        print("✅ Tapped first person")
        return PeopleDetailPage(self.driver)
    
    def tap_first_device(self):
        """Tap on first device in the list"""
        from .device_detail_page import DeviceDetailPage
        # Find first cell in table
        first_cell = self.find_element_by_xpath("//XCUIElementTypeTable/XCUIElementTypeCell[1]")
        self.tap(first_cell)
        print("✅ Tapped first device")
        return DeviceDetailPage(self.driver)
    
    def get_all_people_names(self):
        """Get all people names from the list"""
        cells = self.driver.find_elements(AppiumBy.XPATH, "//XCUIElementTypeTable/XCUIElementTypeCell")
        names = [cell.get_attribute("label") for cell in cells]
        return names
    
    def get_all_device_names(self):
        """Get all device names from the list"""
        cells = self.driver.find_elements(AppiumBy.XPATH, "//XCUIElementTypeTable/XCUIElementTypeCell")
        names = [cell.get_attribute("label") for cell in cells]
        return names
    
    def tap_device_by_name(self, device_name):
        """Tap on a device by its name"""
        from .device_detail_page import DeviceDetailPage
        # Find all cells and search for the one containing the device name
        cells = self.driver.find_elements(AppiumBy.XPATH, "//XCUIElementTypeTable/XCUIElementTypeCell")
        for cell in cells:
            label = cell.get_attribute("label")
            if device_name.lower() in label.lower():
                self.tap(cell)
                print(f"✅ Tapped device: {device_name}")
                return DeviceDetailPage(self.driver)
        
        raise Exception(f"❌ Device '{device_name}' not found in the list")
    
    def tap_person_by_name(self, person_name):
        """Tap on a person by their name"""
        from .people_detail_page import PeopleDetailPage
        # Find all cells and search for the one containing the person name
        cells = self.driver.find_elements(AppiumBy.XPATH, "//XCUIElementTypeTable/XCUIElementTypeCell")
        for cell in cells:
            label = cell.get_attribute("label")
            if person_name.lower() in label.lower():
                self.tap(cell)
                print(f"✅ Tapped person: {person_name}")
                return PeopleDetailPage(self.driver)
        
        raise Exception(f"❌ Person '{person_name}' not found in the list")
