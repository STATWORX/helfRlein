context("check statworx_palette.R")


# test error --------------------------------------------------------------

test_that("input has right format", {
  
  expect_error(statworx_palette("a"),
               "number needs to be numeric")
  expect_error(statworx_palette(reorder = 2),
               "reorder needs to be logical")
  
  expect_warning(statworx_palette(as.numeric(NA)),
                 "number was NA - set to default (4)",
                 fixed = TRUE)
  
})


# test output -------------------------------------------------------------

test_that("default values", {
  
  res_colors <- c("#013848", "#0085AF", "#00A378", "#FF8000")
  expect_equal(statworx_palette(), res_colors)
  
  # test length of output
  expect_equal(length(statworx_palette(20)), 20)
})


# test structure ----------------------------------------------------------

test_that("output class is 'character'", {
  res <- statworx_palette()
  expect_equal(class(res), "character")
  
}) 

