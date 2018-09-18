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

## Tilde
~letters
# [1] "abcdefghijklmnopqrstuvwxyz"
~1:9
# [1] "123456789"

## And
"ABc" & "ABC"
# [1] TRUE TRUE FALSE

## Or
"ABc" | "ABC"
# [1] FALSE FALSE TRUE

## Subset
"ABCDEFGH" %..% 3:5
# [1] "CDE"
```

## Caution

  + `~`: this operator is completely overwritten; so its use in unquoted
    formulas no longer works.
  + `!`, `~`: be careful when using these with pipes (such as `%in%` and
    `%..%`). See the following examples:
```r
"A" %in% "1"
# [1] FALSE

!"A" %in% "1"  # --> here `!` is being used as the traditional `not`
# [1] TRUE

(!"A") %in% "1"  # --> here `!` is being used to switch case
# [1] FALSE

~!letters %..% 3  # --> `letters %..% 3` is evaluated first
# [1] ""
(~!letters) %..% 3  # --> `~!letters` is evaluated first
# [1] "C"
```
