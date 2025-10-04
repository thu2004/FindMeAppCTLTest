"""
Base Page Object for Appium tests
"""

from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class BasePage:
    """Base page object with common methods"""
    
    def __init__(self, driver):
        self.driver = driver
        self.wait = WebDriverWait(driver, 10)
    
    def find_element(self, by, value):
        """Find element with wait"""
        return self.wait.until(EC.presence_of_element_located((by, value)))
    
    def find_element_by_accessibility_id(self, accessibility_id):
        """Find element by accessibility ID"""
        return self.find_element(AppiumBy.ACCESSIBILITY_ID, accessibility_id)
    
    def find_element_by_xpath(self, xpath):
        """Find element by XPath"""
        return self.find_element(AppiumBy.XPATH, xpath)
    
    def tap(self, element):
        """Tap on element"""
        element.click()
    
    def is_element_visible(self, by, value, timeout=5):
        """Check if element is visible"""
        try:
            WebDriverWait(self.driver, timeout).until(
                EC.visibility_of_element_located((by, value))
            )
            return True
        except:
            return False
    
    def get_text(self, element):
        """Get text from element"""
        return element.text
    
    def take_screenshot(self, filename):
        """Take screenshot"""
        self.driver.save_screenshot(filename)
        print(f"📸 Screenshot saved: {filename}")
