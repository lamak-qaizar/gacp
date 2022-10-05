import json


def add_initials(args, filename):
    with open(filename) as f:
        data = f.read()
    initials = json.loads(data)

    initial = args[1]
    name = args[2]
    email = args[3]

    initials[initial] = f"{name} <{email}>"
    json_string = json.dumps(initials, indent=2)

    with open(filename, 'w') as f:
        f.write(json_string)



