# strops

Handle strings using common binary/unary operators.

## Installation

To install it as a package:
```r
if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
remotes::install_github("bjmt/strops")
```
Alternatively, just download and source the `R/strops.R` file.

## Usage

```r
## Add
"A" + "B"            # paste0("A", "B")
# [1] "AB"
+"A"                 # paste0("A", " ")
# [1] "A "

## Substract
"ABC" - "B"          # gsub("B", "", "ABC")
# [1] "AC"
-"ABC"               # paste(rev(strsplit("ABC", "")[[1]]), collapse = "")
# [1] "CBA"
"ABC" - 1            # substr("ABC", 1, 2)
# [1] "AB"
+-"ABC"              # paste0(rev(strsplit("ABC", "")[[1]]), " ")
# [1] "CBA "
-+"ABC"              # paste(rev(strsplit(paste0("ABC", " "), "")[[1]]),
# [1] " CBA"         #       collapse = "")

## Divide
"ABCABC" / "B"       # strsplit("ABCABC", "B")[[1]]
# [1] "A" "CA" "C"
"ABCABC" / 2         # substring("ABCABC", c(1, 4), c(3, 6))
# [1] "ABC" "ABC"

## Multiply
"ABC" * 3            # paste(rep("ABC", 3), collapse = "")
# [1] "ABCABCABC"

## Power
"ABCABCABC" ^ "B"    # gsub("[^B]", " ", "ABCABCABC")
# [1] "A CA CA C"
"ABCABCABC" ^ 3      # substring("ABCABCABC", c(1, 4, 7), c(3, 6, 9))
# [1] "ABC" "ABC" "ABC"
"ABCABCABC" ^ 2      # substring("ABCABCABC", c(1, 3, 5, 7, 9), c(2, 4, 6, 8:9))
# [1] "AB" "CA" "BC" "AB" "C"

## Not
!"ABCabc"            # chartr("a-zA-Z", "A-Za-z", "ABCabc")
# [1] "abcABC"

## Colon
"A":"D"              # paste(LETTERS[1:4], collapse = "")
# [1] "ABCD"

## Tilde
~letters             # paste(letters, collapse = "")
# [1] "abcdefghijklmnopqrstuvwxyz"
~1:9                 # paste(1:9, collapse = "")
# [1] "123456789"
(~+letters) - 1      # paste(letters, collapse = " ")
# [1] "a b c d e f g h i j k l m n o p q r s t u v w x y z"

## And
"ABc" & "ABC"        # strsplit("ABc", "")[[1]] == strsplit("ABC", "")[[1]]
# [1] TRUE TRUE FALSE

## Or
"ABc" | "ABC"        # strsplit("ABc", "")[[1]] != strsplit("ABC", "")[[1]]
# [1] FALSE FALSE TRUE

## Subset
"ABCDEFGH" %..% 3:5  # paste(strsplit("ABCDEFGH", "")[[1]][3:5], collapse = "")
# [1] "CDE"
```

## Caution

  + Method dispatch on binary operators is based on the first argument,
    meaning `1 + "A"` would fail (as opposed to `"A" + 1`).
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
