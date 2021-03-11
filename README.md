# What gives?

Writing 'Co-Authored by ...' in every commit is hard.

`gacp "a commit message" co:fahad,haris` will create the following commit message and push it.

```
a commit message

Co-authored-by: Fahad Khan <fahad.khan@domain.com>
Co-authored-by: Haris Khan <haris.khan@domain.com>
```

# Installation

1. Download and save main.py

2. Create 'initial.json' in the same directory as main.py (see format of file from test_initials.json)

3. Open .bash_profile, and create these 2 functions:

```
function gac() {
  python3 /Users/your-name/path-to-file/main.py "no-push" "$1" "$2"
}
```

```
function gacp() {
  python3 /Users/your-name/path-to-file/main.py "push" "$1" "$2"
}
```

# Usage

- Commit: `gac "commit message"`
- Commit & push: `gac "commit message"`
- Commit & push with co-authors: `gac "commit message" co:fahad,haris`