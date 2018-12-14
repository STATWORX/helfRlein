#'  Palette for STATWORX Corporate Identity
#'
#' @description Palette for Statworx's Corporate Identity colors. 
#' 
#' @details
#' The \code{plot} function gives an example of the colors.
#' 
#' @importFrom grDevices rgb
#' 
#' @author Martin Albers, Jakob Gepp
#' 
#' @exportClass sci
#' @export
#' 
#' @examples
#' plot(sci_palette())
#' 
sci_palette <- function() {
  
  out <- c(main_color = grDevices::rgb(1, 56, 72, maxColorValue = 255),
           accent_color_1   = grDevices::rgb(0, 133, 175, maxColorValue = 255),
           accent_color_2   = grDevices::rgb(0, 163, 120, maxColorValue = 255),
           accent_color_3   = grDevices::rgb(9, 85, 127, maxColorValue = 255),
           highlight  = grDevices::rgb(255, 128, 0, maxColorValue = 255),
           black    = grDevices::rgb(0, 0, 0, maxColorValue = 255),
           text  = grDevices::rgb(105, 105, 105, maxColorValue = 255),
           grey_2     = grDevices::rgb(217, 217, 217, maxColorValue = 255),
           light_gray   = grDevices::rgb(248, 248, 248, maxColorValue = 255),
           special = grDevices::rgb(198, 47, 75, maxColorValue = 255))
  
  class(out) <- "sci"
  
  return(out)
}
