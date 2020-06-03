from SeleniumLibrary import SeleniumLibrary
from SeleniumLibrary.base import keyword
from SeleniumLibrary.keywords import ElementKeywords


class WebConnector(SeleniumLibrary):

    def __init__(self):
        SeleniumLibrary.__init__(self)

    @keyword
    def get_web_element_position(self, locator=None, expected=None):
        web_element_manager = ElementKeywords(self)
        elements = web_element_manager.get_webelements(locator)
        text = ""
        count = 1
        for elem in elements:
            if expected in elem.text:
                web_element_manager.info(
                    "Element '%s' at position '%d' contains text '%s'." % (locator, count, expected))
                return count
            count += 1
            text += elem.text + '\n'

        message = "Element '%s' should have contained text '%s' but " \
                  "its text was '%s'." % (locator, expected, text)
        raise AssertionError(message)
