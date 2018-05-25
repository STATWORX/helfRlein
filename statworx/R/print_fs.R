#' @title print file structure
#'
#' @description Prints the directories and files of the given path.
#'
#' @param path a folder path.
#' @param silent a logical value. If \code{TRUE} the return value is a data.tree
#'   with the file structure and nothing is printed.
#'
#' @export
#' 
#' @return
#'  Either the file structure gets printed or returned.
#'
#' @importFrom data.tree as.Node
#' @author Jakob Gepp
#' @examples
#'
#' print_fs(path = ".")
#' 
print_fs <- function(path = ".", silent = FALSE) {
  
  # get files
  files <- list.files(path = path, 
                      recursive = TRUE,
                      include.dirs = FALSE) 
  
  # transform to data.tree
  df <- data.frame(filename = paste0(basename(path), "/", files))
  file_structure <- data.tree::as.Node(df, pathName = "filename")
  
  # return value
  if (silent) {
    return(file_structure)
  } else {
    print(file_structure)
  }
}
