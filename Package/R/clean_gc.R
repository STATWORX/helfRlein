#' @title Using gc multiple times
#'
#' @description
#' Function that cleans the memory by using gc() numerous times.
#' 
#' @details
#' The function calls \code{gc()} a number of times till the difference of 
#' the memory size is below the \code{threshold}.
#'
#' @param num.gc a numeric that indicates the maximum number of iterations.
#' @param threshold a numeric with the percentage difference. If the change 
#'        in memory size is lower than this, the function stops.
#' @param verbose a boolean. If \code{TRUE} information about the run are 
#'        printed.
#' 
#' @export
#' 
#' @examples 
#' clean_gc(verbose = TRUE)
#' 
clean_gc <- function(num.gc    = 100,
                     threshold = 0.01,
                     verbose   = FALSE) {
  mb.size <- c()
  for (i.gc in c(1:num.gc)) {
    # i.gc <- 1
    tmp.gc <- gc()
    mb.size[i.gc] <- tmp.gc[2,4]
    if (i.gc != 1) {
      if (mb.size[i.gc-1] > mb.size[i.gc] * (1 + threshold)) {
        if (verbose) {
          print(paste0("run: ", i.gc, " more (", mb.size[i.gc], ")"))
        }
      } else {
        if (verbose) {
          print("no more")
        }
        break()
      }
    } else {
      if (verbose) {
        print(paste0("run: ", i.gc, " (Mb size: ", mb.size[i.gc], ")"))
      }
    }
  }
  if (length(mb.size) > 2) {
    if (verbose) {
      print(paste0("Total change in mb after ", length(mb.size),
                   " runs: ", mb.size[1] - data.table::last(mb.size)))
    }
  } else {
    if (verbose) {
      print("gc() was used once.")
    }
  }
  # removing used variables
  rm(num.gc, mb.size, tmp.gc, i.gc)
}


