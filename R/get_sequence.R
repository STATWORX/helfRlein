#' @title Get start and end indices of sequences of patterns
#'
#' @description
#'   Given a vector \code{x} and a \code{pattern}, the function returns the
#'   start and end indices of the sequences with at least \code{minsize}
#'   repetitions of the \code{pattern}.
#'
#' @param x a vector
#' @param pattern the pattern to look for
#' @param minsize the minimum length of the repeating pattern.
#'  Must be higher than 2 for single pattern.
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
#' @author Jakob Gepp, Robin Kraft
#'
get_sequence <- function(x,
                         pattern,
                         minsize = 2L) {
  # check minsize
  if (length(pattern) == 1 & (minsize < 2 | !is.numeric(minsize))) {
    stop("minsize must be an integer >= 2")
  }
  if (!is.integer(minsize) && (ceiling(minsize) - minsize != 0)) {
    warning(paste0("set minsize so next integer: ", ceiling(minsize)))
    minsize <- ceiling(minsize)
  }

  # recursive for pattern with length > 1
  if (length(pattern) == 1) {
    # get indices with the pattern
    x0 <- which(x == pattern)


    # which indices are continous
    seq_index <- which(diff(x0) == 1)
    y <- diff(c(seq_index[1] - 1, seq_index))
    y <- cumsum(ifelse(y == 1, 0, y))

    # check length of y
    if (length(y) == 0) {
      warning("no repeating pattern found")
      return(NULL)
    }

    # get the real x back
    split_pattern <- lapply(split(seq_index, y), function(x) x0[x])

    # add one, which was lost because of diff()
    split_pattern <- lapply(split_pattern, function(x) c(x, max(x) + 1))

    # keep only those respect to the minsize
    split_pattern <-
      split_pattern[sapply(split_pattern, function(x) length(x) >= minsize)]

    # check length of y
    if (length(split_pattern) == 0) {
      warning("no repeating pattern found")
      return(NULL)
    }

    # output format
    out <- t(sapply(split_pattern, range))

  } else {
    # find first pattern
    idx <- which(x == pattern[1])
    # check following patterns
    start <-
      idx[sapply(idx, function(i) {
        all(x[i:(i + (length(pattern) - 1))] == pattern)
        }
      )]
    start <- start[!is.na(start)]
    end <- start + length(pattern) - 1

    # combine start and end for longer patterns
    used <- !(start[-1] - end[-length(end)] <= 1)
    out <- matrix(c(start[c(TRUE, used)], end[c(used, TRUE)]), ncol = 2)

    # check minsize
    idx <- apply(X = out, MARGIN = 1, FUN = diff) >=
      minsize * length(pattern) - 1
    out <- out[idx, , drop = FALSE]

    # check length of y
    if (nrow(out) == 0) {
      warning("no repeating pattern found")
      return(NULL)
    }
  }

  rownames(out) <- NULL
  colnames(out) <- c("min", "max")

  return(out)
}
