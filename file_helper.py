import json


def read_initials(filename):
    with open(filename) as f:
        data = f.read()
    return json.loads(data)
