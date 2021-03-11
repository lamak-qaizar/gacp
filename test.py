import unittest
from main import process_git_command

class TestCLI:
    def __init__(self):
        self.commands = []
        self.messages = []

    def run(self, command):
        self.commands.append(command)

    def out(self, message):
        self.messages.append(message)

    def assertInteraction(self, test_case, commands = [], messages = []):
        test_case.assertListEqual(self.commands, commands)
        test_case.assertListEqual(self.messages, messages)

class MyTestCase(unittest.TestCase):
    def test_commit(self):
        cli = TestCLI()
        process_git_command(["/path/to/script", "no-push", "hello"], cli)
        cli.assertInteraction(self,
            commands = ['git add .',
             'git commit -m "hello"'])

    def test_push(self):
        cli = TestCLI()
        process_git_command(["/path/to/script", "push", "hello"], cli)
        cli.assertInteraction(self,
            commands = ['git add .',
             'git commit -m "hello"',
             'git push'])

    def test_push_with_coauthors(self):
        cli = TestCLI()
        process_git_command(["/path/to/script", "push", "hello", "co:fahad,haris"], cli)
        cli.assertInteraction(self,
            commands = ['git add .',
             'git commit -m "hello\n\nCo-authored-by: Fahad Khan <fahad.khan@careem.com>\nCo-authored-by: Haris Khan <haris.khan@careem.com>"',
             'git push'])

    def test_invalid_initials(self):
        cli = TestCLI()
        process_git_command(["/path/to/script", "push", "hello", "co:blah"], cli)
        cli.assertInteraction(self, messages = ['Invalid co-author initials. Registered initials: fahad, haris, faiq, arham, talha, saad.i, shariq, saad.a'])

if __name__ == '__main__':
    unittest.main()
