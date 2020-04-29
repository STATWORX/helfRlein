#' @title counts NA values in a vector
#'
#' @param x a vector with data
#' @param mean a boolean, if \code{TRUE} instead of the sum the mean of NA's
#'  is calculated.
#'
#' @return returns either the sum or the mean of NA values.
#' @export
#'
#' @examples
#' x <- c(NA, NA, 1, NaN, 0)
#' count_na(x)
#' # [1] 3
#'
#' x <- c(NA, NA, 1, NaN, "0")
#' count_na(x)
#' # [1] 2

count_na <- function(x, mean = FALSE) {
  out <- sum(is.na(x))

  if (mean) {
    out <- mean(is.na(x))
  }

  return(out)
}
