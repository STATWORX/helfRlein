testthat::context("check statusbar")

testthat::test_that("error message", {
  testthat::expect_error(trim(c(1:3)),
               "x is not a character vector.")

})

testthat::test_that("example output is right", {

  x <- c("  Hello world!", "  Hello world! ", "Hello world! ")

  testthat::expect_equal(trim(x, lead = TRUE, trail = TRUE),
               c("Hello world!", "Hello world!", "Hello world!"))
  testthat::expect_equal(trim(x, lead = TRUE, trail = FALSE),
               c("Hello world!", "Hello world! ", "Hello world! "))
  testthat::expect_equal(trim(x, lead = FALSE, trail = TRUE),
               c("  Hello world!", "  Hello world!", "Hello world!"))
  testthat::expect_equal(trim(x, lead = FALSE, trail = FALSE), x)

})
