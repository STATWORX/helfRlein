#'  a palette based on STATWORX's CI colors
#'
#' @description
#'  A palette based on STATWORX's CI colors. 
#' 
#' @param number a numeric \code{(1-9)} with the number of colors
#' @param reorder a boolean if \code{TRUE} the order will be sampled,
#'  which can make groups next to each other a little bit more separable.
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
#'      col = statworx_palette(number, TRUE),
#'      pch = 16, cex = 5)
#'
statworx_palette <- function(number = 4,
                             reorder = FALSE) {
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
  
  #number <- 20
  getPalette <- grDevices::colorRampPalette(as.vector(sci_palette())[c(1,2,3,5)])
  out <- getPalette(number)
  
  if (reorder) {
    out <- out[sample(number)]
  }
  
  return(out)
}

