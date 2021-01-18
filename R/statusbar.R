#' @title A statusbar for for loops
#'
#' @description
#'  This functions prints the progess of a \code{for} loop to the console.
#'
#' @param run the iterator of the \code{for} loop or an integer with the current
#'   loop number.
#' @param max.run either an integer with the maximum number of loops if
#'   \code{run} is also a number, or a vector with all possible iterations in
#'   the correct order.
#' @param width an integer that indicates how wide the progress
#'   bar is printed.
#' @param percent.max is deprecated, use width instead.
#' @param info a string with additional information to be printed at
#'   the end of the line. The default is \code{run}.
#'
#' @return
#'  Has no return value, but prints the progress to the console.
#'
#' @importFrom utils flush.console
#' @export
#' @author Jakob Gepp
#'
#' @examples
#'
#' for (i in 1:200) {
#'   Sys.sleep(0.1)
#'   statusbar(run = i, max.run = 200, width = 60L)
#' }
#'
#' for (i in letters[1:16]) {
#'   Sys.sleep(0.1)
#'   statusbar(run = i, max.run = letters[1:16], width = 60L)
#' }

statusbar <- function(run,
                      max.run,
                      width = 20L,
                      info = run,
                      percent.max = width) {
  # check for old parameter
  if ("percent.max" %in% names(match.call())) {
    warning("'percent.max' is deprecated, please use 'width' instead")
    width <- percent.max
  }

  # check run
  if (length(run) > 1) {
    stop("run needs to be of length one!")
  }
  # check max.run
  if (length(max.run) == 0) {
    stop("max.run has length 0")
  }

  if (length(max.run) > 1 | is.character(max.run)) {
    percent <- which(run == max.run) / length(max.run)
  } else {
    percent <- run / max.run
  }

  percent_step <- round(percent * width, 0)
  progress <- paste0("[",
                      paste0(rep("=", percent_step), collapse = ""),
                      paste0(rep(" ", width - percent_step),
                             collapse = ""),
                      "] ",
                      sprintf("%7.2f", percent * 100, 2),
                      "% - ",
                      info)
  cat("\r", progress)
  flush.console()
}
