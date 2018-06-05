context("check get_sequence")

test_that("the output is right", {
  
  tmp1 <- get_sequence(x = c(0,1,1,0,0,0,0,3,0,0,1,0,423,0,0,0,0,0,1,0),
               pattern = 0,
               minsize = 4L)
  
  res1 <- matrix(c(4,7,14,18),
                 ncol = 2,
                 byrow = TRUE,
                 dimnames = list(NULL, c("min", "max")))
  
  expect_equal(tmp1, res1)
})


test_that("minsize is an integer greater than 2", {
  
  expect_error(get_sequence(x = c(0,1,1,0,0,0,0,3,0,0,1,0,423,0,0,0,0,0,1,0),
                            pattern = 0,
                            minsize = 1L),
               "minsize must be an integer >= 2")
})

test_that("warning if minsize is a numeric", {
  
  expect_warning(get_sequence(x = c(0,1,1,0,0,0,0,3,0,0,1,0,423,0,0,0,0,0,1,0),
                              pattern = 0,
                              minsize = 4.1),
               "set minsize so next integer: 5")
})


test_that("result if minsize is a numeric", {
  
  # there would be a warning because of the numeric 4.2, but this is tested above
  capture_warnings(tmp1 <- get_sequence(x = c(0,1,1,0,0,0,0,3,0,0,1,0,423,0,0,0,0,0,1,0),
                                        pattern = 0,
                                        minsize = 4.2))
  
  res1 <- matrix(c(14,18),
                 ncol = 2,
                 byrow = TRUE,
                 dimnames = list(NULL, c("min", "max")))
  
  expect_equal(tmp1, res1)
})

