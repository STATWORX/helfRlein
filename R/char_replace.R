#' @title Replacement of non-standard characters
#'
#' @description This function replaces non-standard characters (such as the
#' German Umlaut 'ä') with their standard equivalents (in this case 'ae').
#' Arguments enable the user to force all characters to lower-case, trim leading 
#' and trailing whitespace characters or replace all whitespace characters 
#' and dashes with underscores or remove all whitespace characters within the string.
#'
#' @param x character vector, contains special characters needing to be replaced.
#' @param to_lower logical, forces all characters to lower-case
#' @param rm_space logical, removes all whitespace characters within 
#' the string. 
#' @param rm_dash logical, removes all dash-characters within the string. 
#' @param to_underscore logical, replaces all whitespace and dash-characters
#' with underscores.
#' 
#' 
#' @return a character vector with all non-standard characters replaced by their
#' standard counterparts
#' @export
#'
#' @importFrom stringr str_replace_all
#' @importFrom magrittr %>% 
#' 
#' @examples
#' x <- "Élizàldë-González Strasse"
#' char_replace(x)
#' char_replace(x, to_lower = TRUE)
#' char_replace(x, to_lower = TRUE, to_underscore = TRUE)
#' char_replace(x, to_lower = TRUE, rm_space = TRUE, rm_dash = TRUE)

char_replace <- function(x,
                         to_lower = FALSE,
                         trim = TRUE,
                         rm_space = FALSE,
                         rm_dash = FALSE,
                         to_underscore = FALSE) {
  
  if (trim == FALSE & to_underscore == TRUE) {
    warning(
      paste(
      "Trimming is strongly recommended when using to_underscore.",
      "Otherwise any leading or trailing whitespace characters will be",
      "replaced with underscores as well."
      )
    )
  }
  
  input_processed <- x %>% 
    str_replace_all(
      c("ä" = "ae",
        "Ä" = "A",
        "á" = "a",
        "à" = "a",
        "â" = "Â",
        "ã" = "a", 
        "å" = "a", 
        "æ" = "ae",
        "Á" = "A",
        "À" = "A",
        "Â" = "A", 
        "Ã" = "A",
        "Å" = "A", 
        "Æ" = "Ae",
        "ç" = "c",
        "ð" = "d", 
        "é" = "e",
        "è" = "e",
        "ë" = "e",
        "ê" = "e",
        "É" = "E",
        "È" = "E",
        "Ë" = "E",
        "Ê" = "E",
        "ﬁ" = "fi", 
        "ﬂ" = "fl", 
        "ğ" = "g", 
        "Ğ" = "G", 
        "ì" = "i", 
        "í" = "i", 
        "î" = "i", 
        "ï" = "i", 
        "ñ" = "n", 
        "ö" = "oe",
        "ò" = "o", 
        "ó" = "o", 
        "ô" = "o", 
        "õ" = "o",
        "œ" = "oe",
        "ø" = "oe", 
        "Ö" = "Oe",
        "Õ" = "O",
        "Œ" = "Oe",
        "Ø" = "Oe",
        "š" = "s",
        "Š" = "S",
        "ß" = "ss",
        "ü" = "ue",
        "ù" = "u", 
        "ú" = "u", 
        "Ü" = "U",
        "Ú" = "U",
        "Ù" = "U",
        "ý" = "y", 
        "ÿ" = "y", 
        "þ" = "th", 
        "ž" = "z", 
        "Ž" = "Z"))
  
  if (trim == TRUE) {
    input_processed <- input_processed %>% 
      trim()
  }
  
  if (to_lower == TRUE) {
    input_processed <- tolower(input_processed)
  }
  
  if (rm_space == TRUE) {
    input_processed <- input_processed %>% 
      str_replace_all(pattern = " ", replacement = "")
  }
  
  if (rm_dash == TRUE) {
    input_processed <- input_processed %>% 
      str_replace_all(pattern = "-", replacement = "")
  }
  
  if (to_underscore == TRUE) {
    input_processed <- input_processed %>% 
      str_replace_all(pattern = c(" " = "_", 
                                  "-" = "_"))
  }
  
  return(input_processed)
  
}