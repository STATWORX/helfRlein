#' Finding Pattern in R Files
#'
#' @description \code{get_files} searches for matches to argument \code{pattern}
#'   within each R file that is a descendant of parent directory \code{dir}. It
#'   works like a global find function that returns all R files within
#'   \code{dir} that match \code{pattern}. Be careful not to choose a parent
#'   directory has too many subdirectories and files.
#'
#' @param dir A character string that defines the root directory within which
#'   all R files will be analysed
#' @param pattern A character string containing a regular expression to be
#'   matched in all R files found in the specified directory
#' @param suffix A string with a pattern to filter the searched file endings.
#'   The default is ".R$" to only look for R-files. Use "." to search all files.
#'
#' @return Returns a character vector containing all files that match the
#'   pattern
#'
#' @export
#'
#' @author Tobias Krabel
#'
#' @examples
#' \dontrun{
#' # Find all files in . that load packages through library
#' get_files(dir = ".", pattern = "library")
#' }
get_files <- function(dir, pattern = "", suffix = ".R$") {

  if (!is.character(dir)) stop("'dir' must be a character string")
  if (!is.character(pattern)) stop("'pattern' must be a character string")
  if (!dir.exists(dir)) stop(sprintf("Directory '%s' doesn't exist.", dir))

  files <- list.files(path = dir,
                      full.names = TRUE,
                      recursive = TRUE,
                      pattern = suffix,
                      ignore.case = TRUE)


  is_found <- grepl(pattern = pattern,
                    x = vapply(X = files,
                               FUN = function(x) {
                                 paste0(readLines(con = x, warn = FALSE),
                                        collapse = "\n")
                               },
                               FUN.VALUE = "character"))


  output <- gsub(x = files, pattern = paste0("^", dir), replacement = "")

  return(output[is_found])

}
