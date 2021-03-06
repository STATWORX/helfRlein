#' @title Check and create path
#'
#' @description
#'   Checks if the given path exists, if not it creates it.
#'
#'
#' @param path a character vector containing a single path name.
#' @param recursive a logical. Should elements of the path other than the
#'  last be created?
#' @param verbose a logical. If \code{TRUE} a warning is shown when the folder already
#'   exists.
#' @param ... additional options for \link[base]{dir.create}.
#'
#' @seealso
#'  Internaly the function \link[base]{dir.create} is called.
#'
#' @return returns TRUE if a new folder is created, FALSE if not
#' @author Jakob Gepp
#' @export
#'
#' @examples
#' \dontrun{
#' checkdir("testfolder/subfolder")
#' }
#'
checkdir <- function(path, recursive = TRUE, verbose = FALSE, ...) {

  # check input
  if (is.null(path) || is.na(path)) {
    stop("path is NA or NULL")
  }

  # check if dir exists, if not, create it
  if (!file.exists(file.path(path))) {
    dir.create(path = path, recursive = recursive, ...)
    out <- TRUE
  } else {
    if (verbose) {
      warning(paste0(path, " - already exists"))
    }
    out <- FALSE
  }

  return(out)
}
