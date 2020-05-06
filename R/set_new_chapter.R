#' Insert dashes from courser position up to 80 characters
#'
#' @importFrom rstudioapi getActiveDocumentContext insertText
#' @return Hyphens inside RStudio
#' @examples ## NOT RUN
#' @author Matthias Nistler
#'
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