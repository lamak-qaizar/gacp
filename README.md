# GACP

GACP does a git `add`, `commit` & `push`, with the ability to add co-authors.

`gacp "resolved long method code smell" co:fahad,haris` will create the following commit message and push it:

```
resolved long method code smell

Co-authored-by: Fahad Khan <fahad.khan@domain.com>
Co-authored-by: Haris Khan <haris.khan@domain.com>
```

# Installation

Run the following command to install gacp.

```
bash < <(curl -s -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/lamakq/gacp/master/installer.sh)
```

You may need to create a new session of your terminal afterwards.

# Usage

#### Add & commit
`gac "refactored code"`

#### Add, commit & push
`gacp "refactored code"`

#### Add, commit & push with co-authors
`gacp "refactored code" co:fahad,haris`