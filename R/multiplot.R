#' @title Combine multiple ggplots
#'
#' @description
#' This function allows to combine different ggplots into one plot.
#'
#' @details ggplot objects can be passed in \code{...}, or to \code{plotlist}
#'   (as a list of ggplot objects)
#'
#' If the layout is something like \code{matrix(c(1,2,3,3), nrow = 2, byrow = TRUE)},
#' then plot 1 will go in the upper left, 2 will go in the upper right, and 3 will go
#' all the way across the bottom.
#'
#' @param ... multiple ggplots.
#' @param plotlist a list with ggplots.
#' @param cols numeric. Number of columns in the output plot.
#' @param layout a matrix with the layout of the plots. If present, \code{cols}
#'   is ignored.
#'
#' @export
#'
#' @import grid
#'
#' @seealso This is copied from the
#'   \href{http://www.cookbook-r.com/Graphs/}{Cookbook for R}
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
    grid::grid.newpage()
    grid::pushViewport(grid::viewport(
      layout = grid::grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numplots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = grid::viewport(layout.pos.row = matchidx$row,
                                            layout.pos.col = matchidx$col))
    }
  }
}
