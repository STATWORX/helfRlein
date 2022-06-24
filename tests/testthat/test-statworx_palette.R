testthat::context("check statworx_palette.R")


# test error --------------------------------------------------------------

testthat::test_that("input has right format", {

  testthat::expect_error(statworx_palette("a"),
               "number needs to be numeric")
  testthat::expect_error(statworx_palette(reorder = 2),
               "reorder needs to be logical")

  testthat::expect_warning(statworx_palette(as.numeric(NA)),
                 "number was NA - set to default (4)",
                 fixed = TRUE)

})


# test output -------------------------------------------------------------

testthat::test_that("default values", {

  # old scheme
  basecolors <- c(1, 2, 3, 5, 10)
  res_colors <- as.character(sci_palette()[basecolors])
  testthat::expect_equal(statworx_palette(), res_colors)

  # new scheme
  basecolors <- c(1, 2, 3, 5, 10)
  res_colors <- as.character(sci_palette(scheme = "new")[basecolors])
  testthat::expect_equal(statworx_palette(scheme = "new"), res_colors)


  # test length of output
  testthat::expect_equal(length(statworx_palette(20)), 20)
})


# test structure ----------------------------------------------------------

testthat::test_that("output class is 'character'", {
  res <- statworx_palette()
  testthat::expect_equal(class(res), "character")

})
