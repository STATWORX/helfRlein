library(R6)

News <- R6Class("News",
  public = list(
    initialize = function(text = c(paste0("## version ", version), "", "---", "",
                                   "### setup", "",
                                   "- added NEWS.md", ""),
                          version = "0.0.0.9000") {
      # private <- list()
      private$text <- text
      private$version <- version
      private$sub_indx = 4
      private$bul_indx = 7
      },
    print = function(...) {
      cat("NEWS.md: \n \n")
      cat(private$text, sep = "\n")
    },
    get_text = function() {
      return(private$text)
    },
    write = function(file = "NEWS.md") {
      writeLines(private$text, file)
    },
    add_version = function(x) {
      private$text <- c(paste("## version", x), "", "---", "", "",
                       private$text)
      private$sub_indx = 4
      private$bul_indx = 4
    },
    add_subtitle = function(x) {
      private$text <- c(
        private$text[1:private$sub_indx],
        "", paste("###", x), "", "",
        private$text[(private$sub_indx + 1):length(private$text)])
      private$bul_indx = private$sub_indx + 3
    },
    add_bullet = function(x) {
      private$text <- c(
        private$text[1:private$bul_indx],
        paste("-", x),
        private$text[(private$bul_indx + 1):length(private$text)])
      #private$bul_indx = private$bul_indx + 1
    }),
  private = list(
    text = "",
    version = NA,
    sub_indx = NA,
    bul_indx = NA
  )
)


'
my_news <- News$new()
my_news$get_private()

my_news$add_subtitle("improved things 1")
my_news$add_bullet("point 1")
my_news$add_bullet("point 2")
my_news$get_private()
my_news$add_version("0.0.1")
my_news$get_private()
my_news$add_bullet("point 3")
my_news$add_bullet("point 3.1")
my_news$get_private()
my_news$add_subtitle("improved things 2")
my_news$get_private()
my_news$add_bullet("point 4")
my_news$add_bullet("point 4.2")
my_news$get_private()
my_news$add_subtitle("improved things 3")
my_news$add_bullet("point 5")
'


