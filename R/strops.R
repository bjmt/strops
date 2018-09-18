# NOTE: methods for operators involving characters are sealed!!
#       which means these dispatches would probably (?) not be allowed by CRAN

# to check for illegal dispatch use isSealedmethod, eg:
#     isSealedMethod("+", c("character", "character"))
# the following would fail:
#     setMethod("+", signature(e1 = "character", e2 = "character"), ...)

# dispatches involving other objects would not be illegal though; eg:
# "+.universalmotif" <- function(e1, e2) { e1@name <- e2; e1 }

#-------------------------------------------------------------------------------

#' Paste two strings together.
#'
#' For the original man page ?`+` redirects to, see '?Arithmetic'.
#'
#' @param e1 First string.
#' @param e2 Second string.
#'
#' @return Pasted string.
#'
#' @examples
#' "A" + "B"
#' # [1] "AB"
#'
#' @rdname str-plus
#' @export
"+" <- function(e1, e2) UseMethod("+")

#' @rdname str-plus
#' @export
"+.character" <- function(e1, e2) paste0(e1, e2)

#' @rdname str-plus
#' @export
"+.default" <- function(e1, e2) base::`+`(e1, e2)

#-------------------------------------------------------------------------------

#' Substract part of a string.
#'
#' For the original man page ?`-` redirects to, see '?Arithmetic'.
#'
#' @param e1 Target string.
#' @param e2 String to substract.
#'
#' @return Modified e1 string.
#'
#' @examples
#' "ABC" - "B"
#' # [1] "AC"
#'
#' @rdname str-minus
#' @export
"-" <- function(e1, e2) UseMethod("-")

#' @rdname str-minus
#' @export
"-.default" <- function(e1, e2) base::`-`(e1, e2)

#' @rdname str-minus
#' @export
"-.character" <- function(e1, e2) gsub(e2, "", e1, fixed = TRUE)

#-------------------------------------------------------------------------------

#' Split string.
#'
#' For the original man page ?`/` redirects to, see '?Arithmetic'.
#'
#' @param e1 Target string.
#' @param e2 String to split at.
#'
#' @return Character vector split every e2.
#'
#' @examples
#' "ABC" / "B"
#' # [1] "A" "C"
#'
#' @rdname str-div
#' @export
"/" <- function(e1, e2) UseMethod("/")

#' @rdname str-div
#' @export
"/.default" <- function(e1, e2) base::`/`(e1, e2)

#' @rdname str-div
#' @export
"/.character" <- function(e1, e2) do.call(c, strsplit(e1, e2))

#-------------------------------------------------------------------------------

#' Replicate string.
#'
#' For the original man page ?`*` redirects to, see '?Arithmetic'.
#'
#' @param e1 Target string.
#' @param e2 Number of times to replicate.
#'
#' @return Replicated string.
#'
#' @examples
#' "A" * 3
#' # [1] "AAA"
#'
#' @rdname str-mult
#' @export
"*" <- function(e1, e2) UseMethod("*")

#' @rdname str-mult
#' @export
"*.default" <- function(e1, e2) base::`*`(e1, e2)

#' @rdname str-mult
#' @export
"*.character" <- function(e1, e2) ~rep(e1, e2)

#-------------------------------------------------------------------------------

#' Replace specified characters with spaces.
#'
#' For the original man page ?`^` redirects to, see '?Arithmetic'.
#'
#' @param e1 Target string.
#' @param e2 Character(s) to substitute with spaces.
#'
#' @return String e1 with spaces replacing e2 characters.
#'
#' @examples
#' "ABC" ^ "B"
#' # [1] "A C"
#'
#' @rdname str-pow
#' @export
"^" <- function(e1, e2) UseMethod("^")

#' @rdname str-pow
#' @export
"^.default" <- function(e1, e2) base::`^`(e1, e2)

#' @rdname str-pow
#' @export
"^.character" <- function(e1, e2) gsub("[^" + e2 + "]", " ", e1)

#-------------------------------------------------------------------------------

#' Switch case.
#'
#' For the original man page ?`+` redirects to, see '?Logic'.
#'
#' @param x Target string.
#'
#' @return String with switch case.
#'
#' @examples
#' !"abc"
#' # [1] "ABC"
#' !"ABC"
#' # [1] "abc"
#' !"aBc"
#' # [1] "AbC"
#'
#' @rdname str-not
#' @export
"!" <- function(x) UseMethod("!")

#' @rdname str-not
#' @export
"!.character" <- function(x) chartr("a-zA-Z", "A-Za-z", x)

#' @rdname str-not
#' @export
"!.default" <- function(x) base::`!`(x)

#-------------------------------------------------------------------------------

#' Fill in alphabet letters between two characters.
#'
#' For the original man page ?`:` redirects to, see '?base::`:`'.
#'
#' @param e1 First character.
#' @param e2 Second character.
#'
#' @return String with filled in alphabet range.
#'
#' @examples
#' "a":"c"
#' # [1] "abc"
#'
#' @rdname str-colon
#' @export
":" <- function(e1, e2) UseMethod(":")

#' @rdname str-colon
#' @export
":.character" <- function(e1, e2) {
  if (length(e1) != 1 && length(e2) != 1) stop("arguments must be length 1")
  if (e1 %in% letters && e2 %in% letters) {
    e1.i <- which(e1 == letters)
    e2.i <- which(e2 == letters)
    i <- seq(e1.i, e2.i)
    paste(letters[i], collapse = "")
  } else if (e1 %in% LETTERS && e2 %in% LETTERS) {
    e1.i <- which(e1 == LETTERS)
    e2.i <- which(e2 == LETTERS)
    i <- seq(e1.i, e2.i)
    paste(LETTERS[i], collapse = "")
  } else stop("arguments must share same case")
}

#' @rdname str-colon
#' @export
":.default" <- function(e1, e2) base::`:`(e1, e2)

#-------------------------------------------------------------------------------

#' Collapse a character vector.
#'
#' Note: this overrides the original definition for `~`.
#' To get back the original behaviour, run \code{"~" <- base::`~`}.
#'
#' @param x Character vector to collapse.
#'
#' @return Collapse character vector.
#'
#' @examples
#' ~c("A", "B", "C")
#' # [1] "ABC"
#' ~1:5
#' # [1] "12345"
#'
#' @rdname str-tilde
#' @export
"~" <- function(x) paste(x, collapse = "")

#-------------------------------------------------------------------------------

#' Check string equality, per character.
#'
#' @param e1 First string.
#' @param e2 Second string.
#'
#' @return Logical vector.
#'
#' @examples
#' "ABCD" & "ABCE"
#' # [1] TRUE TRUE TRUE FALSE
#'
#' @rdname str-and
#' @export
"&" <- function(e1, e2) UseMethod("&")

#' @rdname str-and
#' @export
"&.default" <- function(e1, e2) base::`&`(e1, e2)

#' @rdname str-and
#' @export
"&.character" <- function(e1, e2) {
  if (length(e1) == 1 && length(e2) == 1) e1 / "" == e2 / ""
  else base::`&`(e1, e2)
}

#-------------------------------------------------------------------------------

#' Check string inequality, per character.
#'
#' @param e1 First string.
#' @param e2 Second string.
#'
#' @return Logical vector.
#'
#' @examples
#' "ABCD" | "ABCE"
#' # [1] FALSE FALSE FALSE TRUE
#'
#' @rdname str-or
#' @export
"|" <- function(e1, e2) UseMethod("|")

#' @rdname str-or
#' @export
"|.default" <- function(e1, e2) base::`|`(e1, e2)

#' @rdname str-or
#' @export
"|.character" <- function(e1, e2) {
  if (length(e1) == 1 && length(e2) == 1) e1 / "" != e2 / ""
  else base::`|`(e1, e2)
}

#-------------------------------------------------------------------------------

#' Subset a string.
#'
#' @param x Target string.
#' @param y Indices to subset on.
#'
#' @return Subsetted string.
#'
#' @examples
#' (~letters) %..% c(1:5, 10:15)
#' # [1] "abcdejklmno"
#'
#' @rdname str-subset
#' @export
"%..%" <- function(x, y) ~substring(x, y, y)
