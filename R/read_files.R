#' @title read multiple files into one data.table
#'
#' @param files pathes to files to be read in
#' @param FUN function to load files in
#' @param ... additional arguments to be passed to \code{FUN}
#'
#' @return combined data.table of the input files
#' @export
#'
#' @examples
#' 
#' \dontrun{
#' # this needs files
#' read_files(files, FUN = readRDS)
#' read_files(files, FUN = readLines)
#' read_files(files, FUN = read.csv, sep = ";")
#' }
#' 
read_files <- function(files, FUN = readLines, ...) {
  
  # load files
  out <- lapply(files, FUN = FUN, ... = ...)
  # set to data.table
  out <- lapply(out, data.table::as.data.table)
  # combine into one data.table
  out <- data.table::rbindlist(out, use.names = TRUE, fill = TRUE)
  
  return(out)
}
