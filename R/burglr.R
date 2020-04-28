#' @title burglg - Stealing code from the web
#'
#' @description
#' With \code{\link{burglr}} you can source r-scripts from the web.
#'
#' @param urls a character vector with web urls indicating the location of an r-script.
#'
#' @return Visual Feedback if the sourcing was successful
#'
#' @details
#'  Well, it is as easy as it sounds. The function takes web URL(s) as input
#'  and evaluates the input in your current R session.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # this needs internet connection
#' burglr(urls = "https://github.com/andrebleier/dive/master/dive.R")
#' }
#'
#' @seealso For more information and updates see
#' \href{https://github.com/andrebleier/burglr}{here}.
#'
#' @importFrom RCurl getURL
#' @author Andre Bleier
#' @note Version 1.0 - f871288d8eae25bcd1dd2bf506f5c47a7cbbc6e4
#'
burglr <- function(urls) {

  parse_single <- function(url) {

    # check if github URL:
    if(grepl("github", url)) {

      # fix blob
      if(grepl("blob", url))
        url <- gsub("[/]blob", "", url)

      # raw prefix
      t.url <- gsub(".*(github.com.*)", "\\1", url)
      url <- paste0("https://raw.", t.url)

    }

    # save file name
    script <- strsplit(url, "[/]")[[1]]
    script <- script[length(script)]

    # check if url contains an r-script
    if (!grepl("[.]R$", script)) stop(paste0("Check URL: ",
                                             url,
                                             ". This is not an R-script."))

    # save global env
    ls_bf <- ls(envir = .GlobalEnv)

    # try curl text
    r_raw <- tryCatch({RCurl::getURL(url = url, followlocation = TRUE)},
                      error = function(e) return(NULL))

    # ill-defined url
    if(is.null(r_raw)) stop("Had problems converting the URL to text. Check the URL.")

    # parse script to env
    tryCatch({eval(parse(text = r_raw), envir = .GlobalEnv)}, error = function(e) {
      return(stop(paste0("Could not evaluate the text in: ", script)))
    })

    # print successful
    cat(paste0("Successfully sourced: ", script, " into the global environment.\n"))

    # check global env
    ls_af <- ls(envir = .GlobalEnv)

    # identify new functions
    FUN <- setdiff(ls_af, ls_bf)

    if (length(FUN)>0) {
      cat(paste0("Have fun using: ", paste0(paste0(FUN, "()"), collapse = ",")))
    }
  }

  # source all urls
  the_source <- sapply(urls, FUN = parse_single)

  # return
  return(cat("\nyou are a sneaky burglr"))
}
