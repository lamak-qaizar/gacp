import json


def read_json(filename):
    with open(filename) as f:
        data = f.read()
    return json.loads(data)
