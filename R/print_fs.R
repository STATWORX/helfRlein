#' @title print file structure
#'
#' @description Prints the directories and files of the given path.
#'
#' @param path a folder path.
#' @param silent a logical value. If \code{TRUE} the return value is a data.tree
#'   with the file structure and nothing is printed.
#' @param depth a positive integer with the depth of the folder structure.
#'
#' @export
#'
#' @return Either the file structure gets printed or returned.
#'
#' @importFrom data.tree Prune as.Node
#' @author Jakob Gepp
#' @examples
#'
#' print_fs(path = ".")
#' 
print_fs <- function(path = ".", silent = FALSE, depth = 2L) {
  
  # check path
  if (length(path) != 1) {
    stop("path must have length one")
  }
  if (!is.character(path)) {
    stop("path must be a character")
  }
  if (!dir.exists(path)) {
    stop("path does not exist")
  }
  
  # check depth
  if (!is.numeric(depth)) {
    stop("depth must be a positive integer")
  }
  if (!is.integer(depth)) {
    depth <- ceiling(depth)
  }
  if (depth <= 0) {
    warning("depth was negative, set to 2")
    depth <- 2L
  }
  
  
  # get files
  files <- list.files(path = path, 
                      recursive = TRUE,
                      include.dirs = FALSE) 
  
  # transform to data.tree
  df <- data.frame(filename = paste0(basename(path), "/", files))
  file_structure <- data.tree::as.Node(df, pathName = "filename")
  
  # pruning
  file_structure$Do(function(node) node$depths <- min(node$Get("level")))
  data.tree::Prune(file_structure, function(node)  node$depths <= depth)
  
  # return value
  if (silent) {
    return(file_structure)
  } else {
    print(file_structure)
    return(NULL)
  }
}
