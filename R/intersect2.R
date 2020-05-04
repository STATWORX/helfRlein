#' @title intersect for multiple input vectors or lists
#'
#' @description
#'  Function to check the intersect within multiple vectors or lists.
#'
#' @param ... vectors to check for intersect or lists.
#'
#' @return
#'  Returns the intersect of all given inputs.
#' @export
#'
#' @seealso I found this function on this post
#' \href{https://stat.ethz.ch/pipermail/r-help/2006-July/109758.html}{here}
#' and adjusted it a bit.
#'
#' @examples
#' intersect2(list(c(1:3), c(1:4)), list(c(1:2),c(1:3)), c(1:2))
#' # [1] 1 2
#'
#' @author Jakob Gepp
#'
intersect2 <- function(...) {
  args <- list(...)
  nargs <- length(args)

  if (nargs <= 1) {
    if (nargs == 1 && is.list(args[[1]])) {
      do.call("intersect2", args[[1]])
    } else {
      args[[1]]
    }
  } else if (nargs == 2) {
    # check type of list elements
    if (length(unique(sapply(args, typeof))) != 1) {
      warning("different input types will be converted")
    }
    intersect(intersect2(args[[1]]), intersect2(args[[2]]))
  } else {
    intersect(intersect2(args[[1]]), intersect2(args[-1]))
  }
}
