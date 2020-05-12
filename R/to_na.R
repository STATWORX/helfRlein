#' @title Replace NaN and Inf with NA
#'
#' @description
#' Takes out \code{NaN} and \code{Inf} and replaces them with \code{NA}
#'
#' @param x a vector
#'
#' @return Returns vector with replaced \code{NA} values.
#' @export
#' @author Daniel Luettgau
#'
#' @examples
#' test <- list(a = c("a", "b", NA),
#'              b = c(NaN, 1,2, -Inf),
#'              c = c(TRUE, FALSE, NA))
#'
#' lapply(test, to_na)
#'
#' ## Output
#' # $a
#' # [1] "a" "b" NA
#'
#' # $b
#' # [1] NA  1  2 NA
#'
#' # $c
#' # [1] TRUE FALSE NA
#'
#' @note --- Idea for improvement
#'
#' Add args to flexible select which scenarios should be set NA
#'
#'   - nan, infinite, other defined values
#'

to_na <- function(x) {
  # check input
  if (!is.vector(x)) {
    stop("input must be a vector")
  }

  # convert input
  if (is.character(x)) {
    return(x)
  } else {
    ifelse(is.infinite(x) | is.nan(x), NA, x)
  }
}
