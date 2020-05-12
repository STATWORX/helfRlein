#' @title Improved strsplit function
#'
#' @description This functions uses \code{\link[base]{strsplit}} and adds the
#' possibility to split and keep the delimiter after or before the given split.
#' Or you can split between two given splits and keep both.
#'
#' @param x character vector, each element of which is to be split. Other
#'   inputs, including a factor, will give an error.
#' @param split character vector (or object which can be coerced to such)
#'   containing regular expression(s) (unless \code{fixed = TRUE}) to use for
#'   splitting. If empty matches occur, in particular if \code{split} has length
#'   0, \code{x} is split into single characters. If \code{split} has length
#'   greater than 1, it is recycled along \code{x}.
#' @param type a charachter. Either to \code{"remove"} or keep the delimiter
#'   \code{"before"}, \code{"between"} or \code{"remove"} the split.
#' @param perl logical. Should Perl-compatible regexps be used? Is \code{TRUE}
#'   for all but \code{"remove"}.
#' @param ... other inputs passed along to \code{\link[base]{strsplit}}
#'
#' @return A list of the same length as \code{x}, the i-th element of which contains
#'   the vector of splits of \code{x[i]}.
#' @export
#' @author Jakob Gepp
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
#' x <- c("3D/MON&SUN 2D/MON&SUN")
#' strsplit(x, split("/", "M"))
#' # [[1]]
#' # [1] "3D"         "MON&SUN 2D" "MON&SUN"
#'
#' @note
#'  TODO see issues for further advancements
#'
strsplit <- function(x,
                     split,
                     type = "remove",
                     perl = FALSE,
                     ...) {

  if (!type %in% c("remove", "before", "after", "between")) {
    stop("type must be remove, after, before or between!")
  }

  if (type == "between" & length(split) != 2) {
    stop("split need no have length two!")
  }
  if (length(split) != 1 & type != "between") {
    split <- split[1]
    warning("there are multiple splits - taking only the first one")
  }

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
  } else if (type == "between") {
    # split between the two given delimiter and keep both
    out <- base::strsplit(
      x = x,
      split = paste0("(?<=", paste0(split, collapse = ""), ")"),
      perl = TRUE,
      ...)

    # split after ab
    index <- lapply(out, endsWith, suffix = paste0(split, collapse = ""))
    index <- lapply(index, function(i) which(i == TRUE) + 1)
    # end with -> gusb ab with a
    out <- lapply(out, function(i) gsub(paste0(split, collapse = ""),
                                        split[1], i))

    # next after endwith add b
    out <- mapply(FUN = function(o, i) {
      o[i] <- paste0(split[2], o[i])
      return(o)
      },
      out, index,
      SIMPLIFY = FALSE)
  }

  return(out)
}
