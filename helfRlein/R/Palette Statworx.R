#'  Palette for STATWORX Corporate Identity
#'
#' @return
#' @export
#'
#' @examples
sci_palette <- function() {
  
  hauptfarbe <- rgb(1, 56, 72, maxColorValue = 255)
  akzent_1 <- rgb(0, 133, 175, maxColorValue = 255)
  akzent_2 <- rgb(0, 163, 120, maxColorValue = 255)
  akzent_3 <- rgb(9, 85, 127, maxColorValue = 255)
  highlight <- rgb(255, 128, 0, maxColorValue = 255)
  schwarz <- rgb(0, 0, 0, maxColorValue = 255)
  fließtext <- rgb(105, 105, 105, maxColorValue = 255)
  grau_2 <- rgb(217, 217, 217, maxColorValue = 255)
  hellgrau <- rgb(248, 248, 248, maxColorValue = 255)

  return(c(hauptfarbe,
           akzent_1,
           akzent_2,
           akzent_3,
           highlight,
           schwarz,
           fließtext,
           grau_2,
           hellgrau
           ))
}
