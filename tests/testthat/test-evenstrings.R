testthat::context("check evenstrings")

testthat::test_that("special cases (eg. NA) are handeld right", {

  testthat::expect_equal(evenstrings(NA, split = "", char = 6),
                         list())
  testthat::expect_equal(evenstrings(c(), split = "", char = 6),
                         list())
  testthat::expect_equal(evenstrings("", split = "", char = 6),
                         list())
  testthat::expect_equal(evenstrings(NULL, split = "", char = 6),
                         list())
  testthat::expect_equal(evenstrings(NaN, split = "", char = 6),
                         list())

})

testthat::test_that("examplpes are working with correct length", {
  x <- "Hello world, this is a test sequence."

  # single split
  tmp1 <- evenstrings(x, split = ",", char = 30, newlines = FALSE)
  res1 <- c("Hello world,", " this is a test sequence.")
  testthat::expect_equal(tmp1, res1)
  testthat::expect_true(all(sapply(res1, nchar) < 30))

  # multiple splits
  tmp2 <- evenstrings(x, split = "[, ]", char = 10, newlines = FALSE)
  res2 <- c("Hello ", "world, ", "this is a ", "test ", "sequence.")
  testthat::expect_equal(tmp2, res2)

  # newlines
  tmp1 <- evenstrings(x, split = ",", char = 30, newlines = TRUE)
  res1 <- c("Hello world,\n this is a test sequence.")
  testthat::expect_equal(tmp1, res1)

})

testthat::test_that("existing warning", {

  x <- "Hello world, this is a test sequence."

  # The following gives a warning because the splits by "," are longer than 3
  testthat::expect_warning(evenstrings(x, split = ",", char = 3),
                 "There are longer lines because of the chosen split pattern")

  # x is not suposed to be a vector
  testthat::expect_warning(evenstrings(c(x, x), split = " ", char = 10),
                 "x is a vector, only the first element is used.")

})
