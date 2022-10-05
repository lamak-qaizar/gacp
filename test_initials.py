import unittest
import json

from initials import add_initials
from file_helper import read_initials


class MyTestCase(unittest.TestCase):

    initial = "test-initial"
    filename = "test_initials.json"

    def test_add_initials(self):
        add_initials(["/path/to/script", self.initial, "Test Name", "test-email@domain.com"], self.filename)
        initials = read_initials(self.filename)
        assert initials[self.initial] == "Test Name <test-email@domain.com>"

    def tearDown(self) -> None:
        initials = read_initials(self.filename)
        initials.pop(self.initial)
        with open(self.filename, 'w') as f:
            json.dump(initials, f, indent=2)
