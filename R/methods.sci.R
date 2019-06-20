# PLOT --------------------------------------------------------------------

#' @param x an object of class \code{sci}.
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

plot.sci <- function(x, ...) {
  graphics::plot(x = seq_along(x),
                 y = rep(1, length(x)),
                 col = x,
                 pch = 16,
                 cex = 8,
                 xlim = c(0, length(x) + 1),
                 ylim = c(0.8,2),
                 ann = FALSE,
                 xaxt = "n",
                 yaxt = "n" )
                 #,
                 #...)
  graphics::text(seq_along(x) - 0.2, rep(1.2, length(x)) , x, srt = 90, pos = 4)
  graphics::text(seq_along(x) + 0.1, rep(1.2, length(x)), names(x) , srt = 90, pos = 4, col = "grey")
  graphics::title("STATWORX's colors")
}
