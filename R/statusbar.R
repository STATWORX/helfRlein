#' @title a statusbar for for loops
#'
#' @description
#'  This functions prints a progess of a for loop at the console.
#'
#' @param run the iterator of the for loop or an integer with the current
#'   loop number.
#' @param max.run either an integer with the maximum number of loops if run is
#'   also a number or a vector with all possible iterations in the right order.
#' @param percent.max an integer that indicates how wide the progress
#'   bar is printed.
#' @param info a string with additionaly information to be printed at
#'   the end of the line. The default is \code{run}.
#'
#' @return
#'  Has no return value, but prints the progress to the console.
#'
#' @importFrom utils flush.console
#' @export
#'
#' @examples
#'
#' for (i in 1:20) {
#'   Sys.sleep(0.1)
#'   statusbar(run = i, max.run = 200, percent.max = 60L)
#' }
#'
#' for (i in letters[1:16]) {
#'   Sys.sleep(0.1)
#'   statusbar(run = i, max.run = letters[1:16], percent.max = 60L)
#' }

statusbar <- function(run,
                      max.run,
                      percent.max = 20L,
                      info = run) {
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

  percent_step <- round(percent * percent.max, 0)
  progress <- paste0("[",
                      paste0(rep("=", percent_step), collapse = ""),
                      paste0(rep(" ", percent.max - percent_step), collapse = ""),
                      "] ",
                      sprintf("%7.2f", percent * 100, 2),
                      "% - ",
                      info)
  cat("\r", progress)
  flush.console()
}
