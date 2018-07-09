#' @title get start and end indices of sequnces of patterns
#' 
#' @description 
#'   Given a vector \code{x} and a \code{pattern}, the functions returns the
#'   start and end indices of the sequences with at least \code{minsize}
#'   repetitions of the \code{pattern}.
#' 
#' @param x a vector
#' @param pattern the pattern to look for
#' @param minsize the minimum length of the repeating pattern
#'
#' @return
#'   Returns a matrix with the range of the sequence. Each row representes a
#'   sequence.
#'
#' @export
#' @examples
#' get_sequence(x = c(0,1,1,0,0,0,0,3,0,0,1,0,423,0,0,0,0,0,1,0),
#'              pattern = 0,
#'              minsize = 4)
#' 
#' #      min max
#' # [1,]   4   7
#' # [2,]  14  18
#'  
#' @author Jakob Gepp
#' 
get_sequence <- function(x,
                         pattern,
                         minsize = 2L) {
  # check minsize
  if (minsize < 2 | !is.numeric(minsize)) {
    stop("minsize must be an integer >= 2")
  }
  if (!is.integer(minsize)) {
    warning(paste0("set minsize so next integer: ", ceiling(minsize)))
    minsize <- ceiling(minsize)
  }
  
  # get indices with the pattern
  x0 <- which(x == pattern)
  
  # which indices are continous
  seq_index <- which(diff(x0) == 1)
  y <- diff(c(seq_index[1] - 1, seq_index))
  y <- cumsum(ifelse(y == 1, 0, y))
  
  # get the real x back
  split_pattern <- lapply(split(seq_index, y), function(x) x0[x])
  
  # add one, which was lost because of diff()
  split_pattern <- lapply(split_pattern, function(x) c(x, max(x)+1))
  
  # keep only those respect to the minsize
  split_pattern <- split_pattern[sapply(split_pattern, function(x) length(x) >= minsize)]
  
  # output format
  out <- t(sapply(split_pattern, range))
  rownames(out) <- NULL
  colnames(out) <- c("min", "max")
  
  return(out)
}



