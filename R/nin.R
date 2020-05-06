#' @title 'not in' operator
#'
#' @description
#'   This negates the '%in%' operator.
#'
#' @param x vector or NULL: the values to be matched. Long vectors are
#'    supported.
#' @param table vector or NULL: the values to be matched against. Long vectors
#'    are not supported.
#' @author Jakob Gepp
#'
#' @return a boolean vector
#' @export
#' @seealso \link[base]{match}
#' @examples
#' c(1,2,3,4) %nin% c(1,2,5)
#' # [1] FALSE FALSE  TRUE  TRUE
#'
`%nin%` <- function(x, table) {
  !match(x, table, nomatch = 0) > 0
}
