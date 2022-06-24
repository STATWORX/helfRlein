#' @title Print file structure
#'
#' @description Prints the directories and files of the given path.
#'
#' @param path a folder path.
#' @param depth a positive integer with the depth of the folder structure.
#' @param print a boolean if TRUE (default), the file structure will be printed
#' @param return a boolean if TRUE, the file structure is returned as a vector.
#'   If FALSE the return is NULL. The default value is FALSE.
#' @param prefix internal character to indicate the indention of depth.
#' @param level internal numeric to indicate the current depth.
#'
#' @export
#'
#' @return Either the file structure or NULL
#'
#' @author Jakob Gepp
#' @examples
#'
#' print_fs(path = ".")
#'
print_fs <- function(path = ".",
                     depth = 2L,
                     print = TRUE,
                     return = FALSE,
                     prefix = "",
                     level = 0) {

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


  # create main path
  if (prefix == "") {
    this_dir <- paste0(prefix, basename(path))
  } else {
    this_dir <- paste0(prefix, "--", basename(path))
  }

  if (depth <= level) {
    sub_dirs <- this_files <- character(0)
  } else {
    # get subfolders
    sub_dirs <- list.dirs(path = path,
                          recursive = FALSE,
                          full.names = TRUE)

    # get files in the current path
    this_files <- setdiff(list.files(path = path,
                                     recursive = FALSE,
                                     include.dirs = FALSE,
                                     full.names = TRUE),
                          sub_dirs)

    # change last file sign
    this_files <- paste0(prefix, " |--", basename(this_files))
    this_files[length(this_files)] <- gsub("|--", "o--",
                                           this_files[length(this_files)],
                                           fixed = TRUE)

    # create sub folder structure
    new_prefix <- paste0(prefix, " |")
    sub_dirs <- sapply(sub_dirs,
                       print_fs,
                       depth = depth,
                       return = TRUE,
                       level = level + 1,
                       prefix = new_prefix)
  }

  # combining folders and files
  file_structure <- unlist(c(this_dir, sub_dirs, this_files), recursive = TRUE)

  if (level == 0) {
    file_structure <- paste0(file_structure, "\n")
  }

  if (print && level == 0) {
    cat(file_structure)
  }

  if (return) {
    return(file_structure)
  } else {
    return(NULL)
  }

}
