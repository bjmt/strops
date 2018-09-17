# strops

Handle strings using common binary/unary operators.

## Installation

```r
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("bjmt/strops")
```

## Usage

```r
## Add
"A" + "B"
# [1] "AB"

## Substract
"ABC" - "B"
# [1] "AC"

## Divide
"ABCABC" / "B"
# [1] "A" "CA" "C"

## Multiply
"ABC" * 3
# [1] "ABCABCABC"

## Power
"ABCABCABC" ^ "B"
# [1] "A CA CA C"

## Not
!"ABCabc"
# [1] "abcABC"

## Colon
"A":"D"
# [1] "ABCD"
```
