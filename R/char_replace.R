#' @title Replacement of non-standard characters
#'
#' @description This function replaces non-standard characters (such as the
#'   German Umlaut 'ä') with their standard equivalents (in this case 'ae').
#'   Arguments enable the user to force all characters to lower-case, trim
#'   leading and trailing whitespace characters or replace all whitespace
#'   characters and dashes with underscores or remove all whitespace characters
#'   within the string.
#'
#' @param x character vector, contains special characters needing to be
#'   replaced.
#' @param to_lower logical, forces all characters to lower-case
#' @param rm_space logical, removes all whitespace characters within the string.
#' @param rm_dash logical, removes all dash-characters within the string.
#' @param to_underscore logical, replaces all whitespace and dash-characters
#'   with underscores.
#' @param trim logical, if whitespaces are trimmed from the start and end. Is
#'   ignored with \code{rm_space == TRUE}.
#'
#' @return a character vector with all non-standard characters replaced by their
#'   standard counterparts
#' @export
#'
#' @importFrom stringr str_replace_all
#' @importFrom magrittr %>%
#'
#' @examples
#' x <- "Élizàldë-González Strasse"
#' char_replace(x)
#' char_replace
#' char_replace(x, to_lower = TRUE, to_underscore = TRUE)
#' char_replace(x, to_lower = TRUE, rm_space = TRUE, rm_dash = TRUE)

char_replace <- function(x,
                         to_lower = FALSE,
                         trim = TRUE,
                         rm_space = FALSE,
                         rm_dash = FALSE,
                         to_underscore = FALSE) {

  if (trim == FALSE & rm_space == TRUE) {
    warning("trim = FALSE is ignored because of rm_sapce = TRUE")
  }

  if (trim == FALSE & to_underscore == TRUE) {
    warning(
      paste(
      "Trimming is strongly recommended when using to_underscore.",
      "Otherwise any leading or trailing whitespace characters will be",
      "replaced with underscores as well."
      )
    )
  }



  char_result <- c(
    # a
    "ae", "A", "a", "a", "a", "a", "a", "ae",
    # A
    "A", "A", "A", "A", "A", "Ae", "c", "d",
    # e
    "e", "e", "e", "e", "E", "E", "E", "E",
    # g
    "g", "G", "i", "i", "i", "i", "n",
    # o
    "oe", "o", "o", "o", "o", "oe", "oe",
    # O
    "Oe", "O", "Oe", "Oe", "s", "S", "ss",
    # u
    "ue", "u", "u", "U", "U", "U", "y", "y",
    # t
    "th", "z", "Z", " ")
  names(char_result) <- c(
    # a
    intToUtf8(228),
    intToUtf8(196),
    intToUtf8(225),
    intToUtf8(224),
    intToUtf8(226),
    intToUtf8(227),
    intToUtf8(229),
    intToUtf8(230),
    # A
    intToUtf8(193),
    intToUtf8(192),
    intToUtf8(194),
    intToUtf8(195),
    intToUtf8(197),
    intToUtf8(198),
    intToUtf8(231),
    intToUtf8(240),
    # e
    intToUtf8(233),
    intToUtf8(232),
    intToUtf8(235),
    intToUtf8(234),
    intToUtf8(201),
    intToUtf8(200),
    intToUtf8(203),
    intToUtf8(202),
    # g
    intToUtf8(287),
    intToUtf8(286),
    intToUtf8(236),
    intToUtf8(237),
    intToUtf8(238),
    intToUtf8(239),
    intToUtf8(241),
    # o
    intToUtf8(246),
    intToUtf8(242),
    intToUtf8(243),
    intToUtf8(244),
    intToUtf8(245),
    intToUtf8(339),
    intToUtf8(248),
    # O
    intToUtf8(214),
    intToUtf8(213),
    intToUtf8(338),
    intToUtf8(216),
    intToUtf8(353),
    intToUtf8(352),
    intToUtf8(223),
    # u
    intToUtf8(252),
    intToUtf8(249),
    intToUtf8(250),
    intToUtf8(220),
    intToUtf8(218),
    intToUtf8(217),
    intToUtf8(253),
    intToUtf8(255),
    # t
    intToUtf8(254),
    intToUtf8(382),
    intToUtf8(381),
    intToUtf8(160)
  )
  input_processed <- str_replace_all(string = x, char_result)


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
