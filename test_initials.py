import unittest
import json

class MyTestCase(unittest.TestCase):

    def test_add_initials(self):
        add_initials(["/path/to/script", "test-initial", "Test Name", "test-email@domain.com"], 'test_initials.json')
        with open("test_initials.json") as f:
            data = f.read()
        initials = json.loads(data)
        assert initials["test-initial"] == "Test Name <test-email@domain.com>"
