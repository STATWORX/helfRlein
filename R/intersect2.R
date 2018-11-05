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
#' @seealso I found this function on this post 
#' \href{https://stat.ethz.ch/pipermail/r-help/2006-July/109758.html}{here}.
#' 
#' @examples
#' intersect2(c(1:3), c(1:4), c(1:2))
#' # [1] 1 2
#' 
#' @author Jakob Gepp
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
    # check type of list elements
    if (length(unique(sapply(args, typeof))) != 1) {
      warning("different input types will be converted")
    }
    intersect(args[[1]], args[[2]])
  } else {
    intersect(args[[1]], intersect2(args[-1]))
  }
}