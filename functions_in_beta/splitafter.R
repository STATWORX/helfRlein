
x <- list(c("3D","/SUN"), "2D", "3D&Sun", "3D/mon/sun")

split <- c("&", "/")


splitafter <- function(x,
                       split) {
  tmp <- x
  
  for (i.split in split) {
    # i.split <- split[1]
    # z <- tmp[[1]]
    l.before <- sapply(tmp, length)
    tmp <- sapply(tmp, function(z) {unlist(strsplit(z, split = i.split, fixed = TRUE))},
                  simplify = FALSE)
    tmp <- lapply(seq_along(tmp), function(i) tmp[[i]][tmp[[i]]  != ""])
    l.after <- sapply(tmp, length)
    #y <- tmp[[1]]
    tmp[l.after > l.before] <-
      sapply(tmp[l.after > l.before],
             function(y) {c(y[1], paste0(i.split, y[-1], sep = ""))},
             simplify = FALSE)
  }
  
  return(tmp)
}

splitafter(x, split)

# this does it too. only before not after

strsplit(x, "(?=[/&])", perl=TRUE)
strsplit(x, "(?<=[/&])", perl=TRUE)
strsplit(x, "(?![/&])", perl=TRUE)
strsplit(x, "(?<![/&])", perl=TRUE)

unlist(strsplit(x, "(?<=[-])", perl=TRUE))