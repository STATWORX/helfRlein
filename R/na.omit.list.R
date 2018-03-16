#' @title remove NA from list
#'
#' @details 
#'    This functions removes NA's from a list. With \code{recursive == TRUE} 
#'    NA's within each listelements are removed as well.
#'
#' @param y a list
#'
#' @return returns the list without NA's
#' @export
#'
#' @examples
#' y <- list(c(1:3), letters[1:4], NA, c(1, NA), list(c(5:6, NA), NA, "A"))
#' na.omit.list(y, recursive = TRUE)
#' 
#' # [[1]]
#' # [1] 1 2 3
#' # 
#' # [[2]]
#' # [1] "a" "b" "c" "d"
#' #
#' # [[3]]
#' # [1] 1
#' #
#' # [[4]]
#' # [[4]][[1]]
#' # [1] 5 6 
#' #
#' # [[4]][[2]]
#' # [1] "A"

na.omit.list <- function(y = list(),
                         recursive = FALSE) {
  if (recursive && anyNA(y, recursive = TRUE)) {
    y <- y[!sapply(y, function(x) all(is.na(x)))]
    y <- sapply(y, na.omit.list, recursive = TRUE)
  } else {
    y <- y[!sapply(y, function(x) all(is.na(x)))]
  }
  return(y)
}