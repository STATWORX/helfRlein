#' @title trim leading or trailing whitespaces
#'
#' @param x a character vector
#' @param lead a boolean. If \code{TRUE} leading whitespaces will be trimed
#' @param trail a boolean. If \code{TRUE} trailing whitespaces will be trimed
#'
#' @return a character vector
#' @export
#' @author Jakob Gepp
#'
#' @seealso Since R 3.5.1 there is \code{\link[base]{trimws}} in the base
#'   package.
#' @examples
#' x <- c("  Hello world!", "  Hello world! ", "Hello world! ")
#' trim(x)
#' # [1] "Hello world!" "Hello world!" "Hello world!"
#'
trim <- function(x, lead = TRUE, trail = TRUE) {
  if (!is.character(x)) {
    stop("x is not a character vector.")
  }
  # check leading spaces
  if (lead == TRUE) {
     x <- sub("^\\s+", "", x)
  }

  # check trailing spaces
  if (trail == TRUE) {
    x <- sub("\\s+$", "", x)
  }

  return(x)
}
