#'  Palette for STATWORX Corporate Identity
#'
#' @description Palette for Statworx´s Corporate Identity colors. 
#' 
#' @details
#' The \code{plot} function gives an example of the colors.
#'
#' @author Martin Albers, Jakob Gepp
#' @usage sci_palette()
#' 
#' @param number a numeric \code{(1-9)} with the number of colors
#' 
#' @export
#' @examples 
#' # plotting three colors
#' plot(sci_palette(3))
#' 
sci_palette <- function(number = 9) {
  
  out <- c(hauptfarbe = rgb(1, 56, 72, maxColorValue = 255),
           akzent_1   = rgb(0, 133, 175, maxColorValue = 255),
           akzent_2   = rgb(0, 163, 120, maxColorValue = 255),
           akzent_3   = rgb(9, 85, 127, maxColorValue = 255),
           highlight  = rgb(255, 128, 0, maxColorValue = 255),
           schwarz    = rgb(0, 0, 0, maxColorValue = 255),
           fließtext  = rgb(105, 105, 105, maxColorValue = 255),
           grau_2     = rgb(217, 217, 217, maxColorValue = 255),
           hellgrau   = rgb(248, 248, 248, maxColorValue = 255))
  
  # check input number
  if (!is.numeric(number)) {
    stop("number needs to be numeric")
  }
  
  if (number > length(out)) {
    stop(paste0("there are only ", length(out), " colors set!"))
  }
  
  out <- out[seq_len(number)]
  
  class(out) <- "sci"
  
  return(out)
}

plot.sci <- function(sci, ...) {
  plot(x = seq_along(sci),
       y = rep(1, length(sci)),
       col = sci,
       pch = 16,
       cex = 8,
       xlim = c(0, length(sci) + 1),
       ann = FALSE,
       xaxt = "n",
       yaxt = "n" , ... = ...)
  text(seq_along(sci), rep(1.2, length(sci)) , sci, srt = 90)
  title("STATWORX´s colors")
}
