#' @title improved strsplit function
#'
#' @description This functions uses \code{\link[base]{strsplit}} and adds the
#' possibility to split and keep the delimiter after or before the given split.
#'
#' @param x character vector, each element of which is to be split. Other
#'   inputs, including a factor, will give an error.
#' @param split character vector (or object which can be coerced to such)
#'   containing regular expression(s) (unless fixed = TRUE) to use for
#'   splitting. If empty matches occur, in particular if split has length 0, x
#'   is split into single characters. If split has length greater than 1, it is
#'   re-cycled along x.
#' @param type a charachter. Either to \code{"remove"} or keep the delimiter
#'   \code{"before"} or \code{"remove"} the split.
#' @param perl logical. Should Perl-compatible regexps be used? Is \code{TRUE}
#'   for \code{"before"} and \code{"remove"}.
#' @param ... other inouts for base::strsplit
#'
#' @return A list of the same length as x, the i-th element of which contains
#'   the vector of splits of x[i].
#' @export
#' @seealso \code{\link[base]{strsplit}} or 
#'   \href{https://stackoverflow.com/questions/15575221}{stackoverflow}
#'    for more details.
#'   
#' @examples
#' x <- c("3D/MON&SUN")
#' strsplit(x, "[/&]")
#' # [[1]]
#' # [1] "3D"  "MON" "SUN"
#' 
#' strsplit(x, "[/&]", type = "before")
#' # [[1]]
#' # [1] "3D"  "/MON" "&SUN"
#' 
#' strsplit(x, "[/&]", type = "after")
#' # [[1]]
#' # [1] "3D/"  "MON&" "SUN"
#' 
#' @author Jakob Gepp
#' 
strsplit <- function(x,
                     split,
                     type = "remove",
                     perl = FALSE,
                     ...) {
  if (type == "remove") {
    # use base::strsplit
    out <- base::strsplit(x = x, split = split, perl = perl, ...)
  } else if (type == "before") {
    # split before the delimiter and keep it
    out <- base::strsplit(x = x,
                          split = paste0("(?<=.)(?=", split, ")"),
                          perl = TRUE,
                          ...)
  } else if (type == "after") {
    # split after the delimiter and keep it
    out <- base::strsplit(x = x,
                          split = paste0("(?<=", split, ")"),
                          perl = TRUE,
                          ...)
  } else {
    stop("type must be remove, after or before!")
  }
  
  return(out)
}


