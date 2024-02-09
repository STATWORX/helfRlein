testthat::context("check sci_palette.R")

# test structure ----------------------------------------------------------

testthat::test_that("output class is 'sci'", {
  res_old <- sci_palette(scheme = "old")
  testthat::expect_equal(class(res_old), "sci")

  res_new <- sci_palette(scheme = "new")
  testthat::expect_equal(class(res_new), "sci")

})

testthat::test_that("input values are strings", {
  msg <- "'scheme' must be either 'old' or 'new'"
  testthat::expect_error(sci_palette(scheme = 1), msg)
  testthat::expect_error(sci_palette(scheme = 1.3), msg)
  testthat::expect_error(sci_palette(scheme = "not old"), msg)
  testthat::expect_error(sci_palette(scheme = TRUE), msg)
  testthat::expect_error(sci_palette(scheme = NULL), msg)
  testthat::expect_error(sci_palette(scheme = NA), msg)
  testthat::expect_error(sci_palette(scheme = NA_character_), msg)

})
