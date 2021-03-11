# What gives?

Writing 'Co-Authored by ...' in every commit is hard.

`gacp "a commit message" co:fahad,haris` will create the following commit message and push it.

```
a commit message

Co-authored-by: Fahad Khan <fahad.khan@domain.com>
Co-authored-by: Haris Khan <haris.khan@domain.com>
```

# Installation

1. Download **main.py**

2. Create **initials.json** in the same directory as **main.py**. Use the same format as **test_initials.json**.

3. Open **~/.bash_profile** in your favourite editor, and create the following functions:

```
function gac() {
  python3 /Users/your-name/path-to/main.py "no-push" "$1" "$2"
}
```

```
function gacp() {
  python3 /Users/your-name/path-to/main.py "push" "$1" "$2"
}
```

4. Reload **.bash_profile** by running `source ~/.bash_profile`

# Usage

#### Commit
`gac "commit message"`

#### Commit & push
`gacp "commit message"`

#### Commit & push with co-authors
`gacp "commit message" co:fahad,haris`