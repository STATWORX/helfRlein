#' Palette for STATWORX Corporate Identity
#'
#'
#' @description Palette for STATWORX Corporate Identity colors.
#'
#' @details
#' The \code{plot} function gives an example of the colors.
#'
#' @param scheme a string that indicates if the "new" or the "old" STATWORX CI is
#'  used. The default is still "old" to not break existing code.
#'
#' @importFrom grDevices rgb
#'
#' @author Martin Albers, Jakob Gepp
#'
#' @export
#'
#' @examples
#' # Plotting the true underlying effects
#' plot(sci_palette())
#'
sci_palette <- function(scheme = "old") {

  if (!is.character(scheme) || is.na(scheme)) {
    stop("'scheme' must be either 'old' or 'new'")
  }

  if (scheme == "old") {
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

  } else if (scheme == "new") {
    out <- c('Tech Blue' = "#0000FF",
             'Deep Black' = "#000000",
             'Super White' = "#FFFFFF",
             grey_1 = "#283440",
             grey_2 = "#6C7D8C",
             grey_3 = "#B6BDCC",
             grey_4 = "#EBF0F2",
             accent_1 = "#FFFF00",
             accent_2 = "#FE0D6C",
             accent_3 = "#00C800")

  } else {
    stop("'scheme' must be either 'old' or 'new'")
  }


  class(out) <- "sci"

  return(out)
}
