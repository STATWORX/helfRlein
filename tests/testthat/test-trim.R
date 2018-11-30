context("check statusbar")

test_that("error message", {
  expect_error(trim(c(1:3)),
               "x is not a character vector.")
  
})

test_that("example output is right", {
  
  x <- c("  Hello world!", "  Hello world! ", "Hello world! ")
  
  expect_equal(trim(x, lead = TRUE, trail = TRUE),
               c("Hello world!", "Hello world!", "Hello world!"))
  expect_equal(trim(x, lead = TRUE, trail = FALSE),
               c("Hello world!", "Hello world! ", "Hello world! "))
  expect_equal(trim(x, lead = FALSE, trail = TRUE),
               c("  Hello world!", "  Hello world!", "Hello world!"))
  expect_equal(trim(x, lead = FALSE, trail = FALSE), x)
  
})
