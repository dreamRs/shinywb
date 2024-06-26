
genId <- function(bytes = 12) {
  paste(format(as.hexmode(sample(256, bytes, replace = TRUE) - 1), width = 2), collapse = "")
}

dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

list1 <- function(x) {
  if (length(x) == 1) {
    list(x)
  }
  else {
    x
  }
}
