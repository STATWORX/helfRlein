#' @title replace NaN and Inf with NA
#'
#' @description 
#' Function to take out \code{NaN} and \code{Inf} and replace them with \code{NA}
#'
#' @param x vector
#'
#' @return Returns vector with with replaced \code{NA}values.
#' @export
#'
#' @examples 
#' test <- list(a = c("a", "b", NA),
#'              b = c(NaN, 1,2, -Inf),
#'              c = c(TRUE, FALSE, NaN, Inf))
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
#' # [1]  1  0 NA NA
#' 
#' @author Daniel Luettgau
#' @note --- Idea
#' Add args to flexible select which scenarios should be set NA
#'   - nan, infinite, other defined values
#'
to_na <- function(x) {
  if (is.character(x)) {
    return(x)
  } else {
    ifelse(is.infinite(x) | is.nan(x),  NA, x) 
  }
}


