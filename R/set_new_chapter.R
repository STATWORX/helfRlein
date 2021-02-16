#' @title Insert dashes from current cursor position up to 80 characters
#'
#' @description This function inserts dashes from the current cursor position up
#'   to 80 characters. It can be used for chapter headings for easier
#'   structuring of your code. You can also assign a shortcut to this function
#'   in RStudio: Go to "Tools" --> "Modify Keyboard Shortcuts..." and search for
#'   "Insert Hyphens (---)".
#'
#' @importFrom rstudioapi getActiveDocumentContext insertText
#' @return Hyphens inside RStudio
#' @author Matthias Nistler
#' @export
set_new_chapter <- function() {
  nchars <- 81

  # grab current document informations
  context <- getActiveDocumentContext()
  # extract courser position in document
  context_col <- context$selection[[1]]$range$end["column"]

  # if line has less than 81 characters, insert hyphens at the current line
  # up to 80 characters
  if (nchars > context_col) {
   insertText(strrep("-", nchars - context_col))
  }
}
