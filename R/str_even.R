#' Title
#'
#' @param input 
#' @param tolower 
#' @param space_remove 
#'
#' @return
#' @export
#'
#' @examples
str_even <- function(input, tolower = TRUE, space_remove = FALSE){
  
  input_processed <- input %>% 
    str_replace_all(
      c("ä" = "ae",
        "ö" = "oe",
        "ü" = "ue",
        "Ä" = "A",
        "Ö" = "O",
        "Ü" = "U",
        "é" = "e",
        "è" = "e",
        "É" = "E",
        "È" = "E",
        "ë" = "e",
        "Ë" = "E",
        "á" = "a",
        "à" = "a",
        "Á" = "A",
        "À" = "A",
        " " = "_",
        "-" = "_")
    )
  
  if(tolower == TRUE){
    input_processed <- tolower(input_processed)
  }
  
  if(space_remove == TRUE){
    input_processed <- input_processed %>% 
      str_replace_all(pattern = "_", replacement = "")
  }
  
  return(input_processed)
  
}