# PLOT --------------------------------------------------------------------

#' @param sci an object of class \code{sci}.
#' @param ... arguments to be passed to method
#' @rdname sci_palette
#' 
#' @importFrom graphics plot title text
#' 
#' @method plot sci
#' @export
#' 
#' @examples
#' # Plotting the true underlying effects
#' plot(sci_palette())
#' 

plot.sci <- function(sci, ...) {
  graphics::plot(x = seq_along(sci),
                 y = rep(1, length(sci)),
                 col = sci,
                 pch = 16,
                 cex = 8,
                 xlim = c(0, length(sci) + 1),
                 ann = FALSE,
                 xaxt = "n",
                 yaxt = "n" ,
                 ...)
  graphics::text(seq_along(sci), rep(1.2, length(sci)) , sci, srt = 90)
  graphics::title("STATWORX's colors")
}