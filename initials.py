import json
import sys
import os

from file_helper import read_initials

CURRENT_DIRECTORY = os.path.dirname(os.path.realpath(__file__))


def add_initials(args, filename):
    initials = read_initials(filename)

    initial = args[1]
    name = args[2]
    email = args[3]

    initials[initial] = f"{name} <{email}>"

    with open(filename, 'w') as f:
        json.dump(initials, f, indent=2)


if __name__ == '__main__':
    add_initials(sys.argv, filename=CURRENT_DIRECTORY + '/initials.json')


