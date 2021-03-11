import sys
import os
import json

initials = {}


class TestableCLI:
    def out(self, message):
        print(message)

    def run(self, command):
        os.system(command)


class Arguments:
    def __init__(self, args):
        self.file_path = args[0]
        self.push = args[1]
        self.commit_message = args[2]
        self.coauthors = (Initials(args[3]) if len(args) >= 4 else Initials()).to_coauthors()

    def parse(self):
        if self.coauthors.are_not_valid():
            return InvalidCoauthorsCommand()
        if self.push == "push":
            return GitPushCommand(GitCommitCommand(self.commit_message, self.coauthors))
        return GitCommitCommand(self.commit_message, self.coauthors)


class Initials:
    def __init__(self, coauthors_arg=None):
        self.coauthor_initials = []

        if coauthors_arg:
            coauthors_str = coauthors_arg.split(":")[1]
            self.coauthor_initials = coauthors_str.split(",")

    def to_coauthors(self):
        if not set(self.coauthor_initials).issubset(set(initials.keys())):
            return InvalidCoauthors()
        if len(self.coauthor_initials) == 0:
            return NoCoauthors()
        return Coauthors(self.coauthor_initials)


class Coauthors:
    def __init__(self, coauthor_initials):
        self.coauthor_initials = coauthor_initials

    def are_not_valid(self):
        return False

    def string(self):
        emails = [initials[key] for key in self.coauthor_initials]
        return '\n\n' + '\n'.join(map('Co-authored-by: {0}'.format, emails))


class NoCoauthors:
    def are_not_valid(self):
        return False

    def string(self):
        return ''


class InvalidCoauthors:
    def are_not_valid(self):
        return True

    def string(self):
        return ''


def process_git_command(args, cli, filename='initials.json'):
    with open(filename) as f:
        data = f.read()

    global initials
    initials = json.loads(data)
    gitCommand = Arguments(args).parse()
    gitCommand.run(cli)


class InvalidCoauthorsCommand:
    def run(self, cli):
        cli.out('Invalid co-author initials. Registered initials: ' + ', '.join(initials.keys()))


class GitCommitCommand:
    def __init__(self, commit_message, coauthors):
        self.commit_message = commit_message
        self.coauthors = coauthors

    def run(self, cli):
        cli.run('git add .')
        cli.run('git commit -m "' + self.commit_message + self.coauthors.string() + '"')


class GitPushCommand:
    def __init__(self, git_commit):
        self.gitCommit = git_commit

    def run(self, cli):
        self.gitCommit.run(cli)
        cli.run('git push')


if __name__ == '__main__':
    process_git_command(sys.argv, TestableCLI())
