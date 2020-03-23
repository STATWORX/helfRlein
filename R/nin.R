#' @title 'not in' operator
#'
#' @description 
#'   This negates the '%in%' operator.
#'
#' @return a boolean vector
#' @export
#'
#' @examples
#' c(1,2,3,4) %nin% c(1,2,5)
#' 
`%nin%` <- Negate(`%in%`)
