# GACP

GACP does a git `add`, `commit` & `push`, with the ability to add co-authors.

`gacp "resolved long method code smell" co:fahad,haris` will create the following commit message and push it:

```
resolved long method code smell

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

#### Add & commit
`gac "refactored code"`

#### Add, commit & push
`gacp "refactored code"`

#### Add, commit & push with co-authors
`gacp "refactored code" co:fahad,haris`