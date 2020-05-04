#' @title combine multiple ggplots
#'
#' @description
#' Functions that allows to combine diffrent ggplots into one plot.
#'
#' @details ggplot objects can be passed in ..., or to plotlist (as a list of
#' ggplot objects) - cols: Number of columns in layout - layout: A matrix
#' specifying the layout. If present, 'cols' is ignored.
#'
#' If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE), then
#' plot 1 will go in the upper left, 2 will go in the upper right, and 3 will go
#' all the way across the bottom.
#'
#' @param ... multiple ggplots.
#' @param plotlist a list with ggplots.
#' @param cols numeric. Number of columns in the output plot.
#' @param layout a matrix with the layout of the plots.
#'
#' @export
#'
#' @import grid
#'
#' @seealso This is copied from the
#'   \href{http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/}{Cookbook
#'    for R}
#'
#' @author Cookbook for R
#'

multiplot <- function(..., plotlist = NULL, cols = 1, layout = NULL) {

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numplots <- length(plots)

  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numplots / cols)),
                     ncol = cols, nrow = ceiling(numplots / cols))
  }

  if (numplots == 1) {
    print(plots[[1]])
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numplots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
