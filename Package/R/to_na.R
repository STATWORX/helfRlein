# Function to take out NANs and infinits and replace them with NA

to_na <- function(x) {
  if (is.character(x)) {
    return(x)
  } else {
    ifelse(is.infinite(x) | is.nan(x),  NA, x) 
  }
}

#1 --- Idea
# Add args to flexible select which scenarios should be set NA
#   - nan, infinite, other defined values


#2 --- Testszenario
#test <- list(a <- c("a", "b"), b <- c(NaN, 1,2, -Inf), c <- c(T, F, NaN, Inf))

#lapply(test, to_na)
