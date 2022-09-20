#' @title Read multiple files into one \code{data.table}
#'
#' @description This function reads multiple files into one \code{data.table}
#'
#' @param files paths to files to be read in
#' @param fun function to load files in
#' @param unique a boolean, that indicates if the result table is made unique
#' @param FUN deprecated, use \code{fun} instead.
#' @param ... additional arguments to be passed to \code{fun}
#'
#' @return combined \code{data.table} of the input files
#' @export
#'
#' @importFrom data.table as.data.table rbindlist
#' @author Jakob Gepp
#' @examples
#'
#' \dontrun{
#' # this needs files
#' read_files(files, fun = readRDS)
#' read_files(files, fun = readLines)
#' read_files(files, fun = read.csv, sep = ";")
#' }
#'
read_files <- function(files,
                       fun = readLines,
                       FUN = readLines,
                       unique = FALSE, ...) {
  # check arguments
  this_param <- as.list(match.call(expand.dots = FALSE))

  if (!is.null(this_param$FUN) &&
      as.character(this_param$FUN) != "readLines") {
    warning(paste0("'FUN' has priority over 'fun' wihtin lapply.",
                   " It is deprecated, use fun instead"))
    fun <- FUN
  }


  # load files
  out <- lapply(files, FUN = fun, ... = ...)
  # set to data.table
  out <- lapply(out, data.table::as.data.table)
  # combine into one data.table
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  # make unique
  if (unique == TRUE) {
    out <- unique(out)
  }

  return(out)
}
