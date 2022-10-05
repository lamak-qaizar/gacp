import json


def add_initials(args, filename):
    with open(filename) as f:
        data = f.read()
    initials = json.loads(data)

    initial = args[1]
    name = args[2]
    email = args[3]

    initials[initial] = f"{name} <{email}>"

    with open(filename, 'w') as f:
        json.dump(initials, f, indent=2)



