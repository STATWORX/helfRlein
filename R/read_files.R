#' @title read multiple files into one data.table
#'
#' @param files pathes to files to be read in
#' @param fun function to load files in
#' @param ... additional arguments to be passed to \code{fun}
#'
#' @return combined data.table of the input files
#' @export
#'
#' @importFrom data.table as.data.table rbindlist
#' @examples
#' @author Jakob Gepp
#'
#' \dontrun{
#' # this needs files
#' read_files(files, fun = readRDS)
#' read_files(files, fun = readLines)
#' read_files(files, fun = read.csv, sep = ";")
#' }
#'
read_files <- function(files, fun = readLines, ...) {

  # load files
  out <- lapply(files, FUN = fun, ... = ...)
  # set to data.table
  out <- lapply(out, data.table::as.data.table)
  # combine into one data.table
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)

  return(out)
}
