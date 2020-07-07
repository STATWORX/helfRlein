context("check sci_palette.R")

# test structure ----------------------------------------------------------

test_that("output class is 'sci'", {
  res <- sci_palette()
  expect_equal(class(res), "sci")

})
