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
#' @examples
#'
#' print_fs(path = ".")
#' 
print_fs <- function(path = ".", silent = FALSE) {
  files <- list.files(path = path, 
                      recursive = TRUE,
                      include.dirs = FALSE) 
  df <- data.frame(filename = paste0(basename(path), "/", files))
  file_structure <- data.tree::as.Node(df, pathName = "filename")
  if (silent) retrun(file_structure)
  print(file_structure)
}
