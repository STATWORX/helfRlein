context("check sci_palette.R")

# test structure ----------------------------------------------------------

test_that("output class is 'sci'", {
  res_old <- sci_palette(scheme = "old")
  expect_equal(class(res_old), "sci")

  res_new <- sci_palette(scheme = "new")
  expect_equal(class(res_new), "sci")

})

test_that("input values are strings", {
  msg <- "'scheme' must be either 'old' or 'new'"
  expect_error(sci_palette(scheme = 1), msg)
  expect_error(sci_palette(scheme = 1.3), msg)
  expect_error(sci_palette(scheme = "not old"), msg)
  expect_error(sci_palette(scheme = TRUE), msg)
  expect_error(sci_palette(scheme = NULL), msg)
  expect_error(sci_palette(scheme = NA), msg)
  expect_error(sci_palette(scheme = NA_character_), msg)

})
