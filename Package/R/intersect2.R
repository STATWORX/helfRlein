#' @title intersect for multiple input vectors
#' 
#' @description 
#'  Function to check the intersect within multiple vectors.
#'
#' @param ... vectors to check for intersect
#'
#' @return
#'  Returns the intersect of all given input vectors.
#' @export
#'
#' @examples
#' intersect2(c(1:3), c(1:4), c(1:2))
#' # [1] 1 2
#' 
intersect2 <- function(...) {
  args <- list(...)
  nargs <- length(args)
  if(nargs <= 1) {
    if(nargs == 1 && is.list(args[[1]])) {
      do.call("intersect2", args[[1]])
    } else {
      stop("cannot evaluate intersection fewer than 2 arguments")
    }
  } else if(nargs == 2) {
    intersect(args[[1]], args[[2]])
  } else {
    intersect(args[[1]], intersect2(args[-1]))
  }
}