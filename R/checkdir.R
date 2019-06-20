#' @title Check and create path
#'
#' @description 
#'   Checks if the given path exists, if not it creates it.
#'   
#'   
#' @param path a character vector containing a single path name. 
#' @param recursive a logical. Should elements of the path other than the
#'  last be created?
#' @param ... additional options for \link[base]{dir.create}.
#'
#' @seealso 
#'  Internaly the function \link[base]{dir.create} is called.
#'
#' @return returns TRUE if a new folder is created, FALSE if not
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' checkdir("testfolder/subfolder")
#' } 
#' 
checkdir <- function(path, recursive = TRUE, ...) {
  
  # check if dir exists, if not, create it
  if (!file.exists(path)) {
    dir.create(path = path, recursive = recursive, ...)
    out <- TRUE
  } else {
    warning(paste0(path, " - already exists"))
    out <- FALSE
  }
  
  return(out)
}
