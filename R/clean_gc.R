#' @title Using gc multiple times
#'
#' @description
#' Cleans the memory by using \code{gc()} numerous times.
#'
#' @details
#' The function calls \code{gc()} until the difference in
#'  memory size falls below the \code{threshold}.
#'
#' @param num_gc a numeric that indicates the maximum number of iterations.
#' @param threshold a numeric with the percentage difference. If the change
#'        in memory size falls below the threshold, the function stops.
#' @param verbose a boolean. If \code{TRUE}, information about the run is
#'        printed.
#'
#' @export
#' @importFrom data.table last
#'
#' @examples
#' clean_gc(verbose = TRUE)
#'
#' @author Jakob Gepp
#'
clean_gc <- function(num_gc    = 100,
                     threshold = 0.01,
                     verbose   = FALSE) {
  mb_size <- c()
  for (i_gc in c(1:num_gc)) {
    tmp_gc <- gc()
    mb_size[i_gc] <- tmp_gc[2, 4]
    if (i_gc != 1) {
      if (mb_size[i_gc - 1] > mb_size[i_gc] * (1 + threshold)) {
        if (verbose) {
          print(paste0("run: ", i_gc, " more (", mb_size[i_gc], ")"))
        }
      } else {
        if (verbose) {
          print("no more")
        }
        break
      }
    } else {
      if (verbose) {
        print(paste0("run: ", i_gc, " (Mb size: ", mb_size[i_gc], ")"))
      }
    }
  }
  if (length(mb_size) > 2) {
    if (verbose) {
      print(paste0("Total change in mb after ", length(mb_size),
                   " runs: ", mb_size[1] - data.table::last(mb_size)))
    }
  } else {
    if (verbose) {
      print("gc() was used once.")
    }
  }
  # removing used variables
  rm(num_gc, mb_size, tmp_gc, i_gc)
}
