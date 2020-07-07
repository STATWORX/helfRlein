context("check get_sequence")

test_sequence <- c(0, 1,   1, 0, 0, 0, 0, 3, 0, 0,
                   1, 0, 423, 0, 0, 0, 0, 0, 1, 0)
test_that("the output is right", {

  tmp1 <- get_sequence(x = test_sequence,
                       pattern = 0,
                       minsize = 4L)

  res1 <- matrix(c(4, 7, 14, 18),
                 ncol = 2,
                 byrow = TRUE,
                 dimnames = list(NULL, c("min", "max")))

  expect_equal(tmp1, res1)

  x <- c(1, 2, 4,
         0, 0, 1, 2, 0,
         1, 2, 4, 1, 2, 4,
         0, 1, 1, 1,
         1, 2, 4,
         0, 0, 0,
         1, 2, 4,
         1, 2, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1,
         1, 2, 4, 1, 2, 4,
         0)
  tmp2 <- get_sequence(x = x, pattern = c(1, 2, 4),  minsize = 2)
  res2 <- matrix(c(9, 14, 40, 45),
                 ncol = 2,
                 byrow = TRUE,
                 dimnames = list(NULL, c("min", "max")))

  expect_equal(tmp2, res2)
})

test_that("repeatting pattern", {

  tmp1 <- get_sequence(x = c(0, 1, 1, 0, 1, 1, 0, 0),
                       pattern = c(0, 1, 1),
                       minsize = 2L)

  res1 <- matrix(c(1, 6),
                 ncol = 2,
                 byrow = TRUE,
                 dimnames = list(NULL, c("min", "max")))

  expect_equal(tmp1, res1)

  tmp2 <- get_sequence(x = c(0, 1, 1, 0, 1, 1, 0, 1, 0),
                       pattern = c(1, 1),
                       minsize = 1L)

  res2 <- matrix(c(2, 3, 5, 6),
                 ncol = 2,
                 byrow = TRUE,
                 dimnames = list(NULL, c("min", "max")))

  expect_equal(tmp2, res2)


})


test_that("minsize is right for single pattern", {

  expect_error(get_sequence(x = test_sequence,
                            pattern = 0,
                            minsize = 1L),
               "minsize must be an integer >= 2")
})

test_that("warning if minsize is a numeric", {

  expect_warning(get_sequence(x = test_sequence,
                              pattern = 0,
                              minsize = 4.1),
               "set minsize so next integer: 5")
})


test_that("result if minsize is a numeric", {

  # there would be a warning because of the numeric 4.2
  # but this is tested above
  capture_warnings(tmp1 <- get_sequence(x = test_sequence,
                                        pattern = 0,
                                        minsize = 4.2))

  res1 <- matrix(c(14, 18),
                 ncol = 2,
                 byrow = TRUE,
                 dimnames = list(NULL, c("min", "max")))

  expect_equal(tmp1, res1)
})

test_that("input is a character vector", {
  x <- c(letters[c(1, 1, 2, 3, 1, 1, 1, 1, 2)])
  tmp1 <- get_sequence(x, pattern = "a")
  res1 <- matrix(c(1, 2, 5, 8),
                 ncol = 2,
                 byrow = TRUE,
                 dimnames = list(NULL, c("min", "max")))
  expect_equal(tmp1, res1)

  tmp2 <- get_sequence(x, pattern = c("a", "a"))
  res2 <- matrix(c(5, 8),
                 ncol = 2,
                 byrow = TRUE,
                 dimnames = list(NULL, c("min", "max")))

  expect_equal(tmp2, res2)
})

test_that("no pattern ocours", {
  x <- c(2, 1, 2, 1, 3)
  expect_warning(res1 <- get_sequence(x, pattern = 1, minsize = 2),
                 "no repeating pattern found")
  expect_equal(res1, NULL)

  x <- c(2, 1, 2, 1, 3)
  expect_warning(res1 <- get_sequence(x, pattern = c(1, 3), minsize = 2),
                 "no repeating pattern found")
  expect_equal(res1, NULL)

})
