#'  A palette based on STATWORX's CI colors
#'
#' @description
#'  A palette based on STATWORX's CI colors.
#'
#' @param number a numeric with the number of colors.
#'  The default is the length of \code{basecolors}.
#' @param reorder a boolean, if \code{TRUE} the order will be sampled,
#'  which can make groups next to each other a little bit more separable.
#' @param basecolors a numeric vector with the used color indices of
#' \code{\link{sci_palette}}.
#'
#' @importFrom grDevices rgb colorRampPalette
#'
#' @author Jakob Gepp
#'
#' @export
#'
#' @examples
#' number <- 16
#' plot(data.frame(x =  1:number, y = 1),
#'      col = statworx_palette(number, FALSE),
#'      pch = 16, cex = 5)
#'
statworx_palette <- function(number = length(basecolors),
                             reorder = FALSE,
                             basecolors = c(1, 2, 3, 5, 10)) {
  # check input format
  if (!is.numeric(number)) {
    stop("number needs to be numeric")
  }

  if (!is.logical(reorder)) {
    stop("reorder needs to be logical")
  }

  if (length(number) > 1) {
    stop("number must have length one")
  }

  if (is.na(number)) {
    number <- 4
    warning("number was NA - set to default (4)")
  }

  getpalette <-
    grDevices::colorRampPalette(as.vector(sci_palette())[basecolors])

  out <- getpalette(number)

  if (reorder) {
    out <- out[sample(number)]
  }

  return(out)
}
