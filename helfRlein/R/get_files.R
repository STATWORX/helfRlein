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
#'
#' @return Returns a character vector containing all files that match the
#'   pattern
#'
#' @importFrom magrittr %>%
#' @importFrom purrr map_chr
#' @importFrom readr read_file
#'
#' @export
#'
#' @author Tobias Krabel
get_files <- function(dir, pattern = "") {
  
  stopifnot(is.character(dir), is.character(pattern))
  if (!dir.exists(dir)) stop(paste0("Directory '", dir, "' doesn't exist."))
  
  files <- list.files(dir, full.names = TRUE, recursive = TRUE, 
                      pattern = "*.R", ignore.case = TRUE) 
  
  is_found <- files %>%
    map_chr(., read_file) %>%
    grepl(x = ., pattern = pattern)
  
  files[is_found]
  
}