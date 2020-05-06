#' @title Get size of objects in environment
#'
#' @description
#' Creates a sorted data.table with the size of objects in a specified
#' environment.
#'
#' @param env an environment, the default is the \code{.GlobalEnv}.
#' @param unit the units to be used in formatting and printing the size:
#'   "b", "Kb", "Mb", "Gb", "Tb", "Pb", "B", "KB", "MB", "GB", "TB" and "PB".
#'
#' @return Returns a data.table with the size of objects in the given
#' environment
#'
#' @importFrom data.table data.table
#' @importFrom utils object.size
#' @export
#' @author Jakob Gepp
#'
#' @examples
#' DT <- object_size_in_env(env = environment())
#'
object_size_in_env <- function(env = .GlobalEnv, unit = "Mb") {

  # get objects
  tmp_ls <- ls(envir = env)

  if (length(tmp_ls) == 0) {
    return("no objects in this environment.")
  }

  # create data.table with names and size
  size_table <- data.table::data.table(
    OBJECT = tmp_ls,
    SIZE = sapply(tmp_ls,
                  function(x) {
                    tmp <- format(object.size(get(x, envir = env)), unit = unit)
                    return(as.numeric(gsub("[[:alpha:]]", "", tmp)))
                  },
                  simplify = TRUE),
    UNIT = unit)

  size_table <- size_table[order(size_table$SIZE, decreasing = TRUE), ]

  return(size_table)
}
