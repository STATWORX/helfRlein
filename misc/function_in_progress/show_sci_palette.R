#' show_sci_palette
#'
#' @description \code{show_sci_palette()} plots a graphic with STATWORX´s Corporate Identity colors.
#'
#' @return Returns a plot 
#'
#' @importFrom ggplot2 ggplot
#'
#' @author Martin Albers
#' @export
#' 
show_sci_palette <- function() {
  ggplot2::ggplot(data.frame(x = 1:9, y = 1:9, z = as.factor(1:9))) +
    geom_point(aes(x, y, color = z), size = 9) +
    scale_color_manual(labels=c("1) Hauptfarbe: #013848",
                                "2)Akzent_1: #0085af",
                                "3) Akzent_2: #00a378",
                                "4) Akzent_3: #09557f",
                                "5) Highlight: #ff8000",
                                "6) Weiß: #ffffff",
                                "7) Fließtext: #696969",
                                "8) Grau_2: #d9d9d9",
                                "9) Hellgrau: #f8f8f8"),
                       values = c("#013848", "#0085af","#00a378",
                                  "#09557f","#ff8000", "#ffffff",
                                  "#696969", "#d9d9d9","#f8f8f8")) +
    theme_minimal()
}

