#'  Palette for STATWORX Corporate Identity
#'
#' @description Palette for Statworx's Corporate Identity colors. 
#' 
#' @details
#' The \code{plot} function gives an example of the colors.
#'
#' @param number a numeric \code{(1-9)} with the number of colors
#' 
#' @importFrom grDevices rgb
#' 
#' @author Martin Albers, Jakob Gepp
#' 
#' @exportClass sci
#' @export
#' 
#' @examples
#' sci_palette(3) # plotting three colors
#' 
sci_palette <- function(number = NULL) {
  
  out <- c(hauptfarbe = grDevices::rgb(1, 56, 72, maxColorValue = 255),
           akzent_1   = grDevices::rgb(0, 133, 175, maxColorValue = 255),
           akzent_2   = grDevices::rgb(0, 163, 120, maxColorValue = 255),
           akzent_3   = grDevices::rgb(9, 85, 127, maxColorValue = 255),
           highlight  = grDevices::rgb(255, 128, 0, maxColorValue = 255),
           schwarz    = grDevices::rgb(0, 0, 0, maxColorValue = 255),
           fliestext  = grDevices::rgb(105, 105, 105, maxColorValue = 255),
           grau_2     = grDevices::rgb(217, 217, 217, maxColorValue = 255),
           hellgrau   = grDevices::rgb(248, 248, 248, maxColorValue = 255))
  
  # check input number
  if (is.null(number)) {
    number <- length(out)
  }
  
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
