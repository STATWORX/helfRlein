context("test-sci_palette.R")


# test error --------------------------------------------------------------

test_that("input is a number within the set", {
  res <- sci_palette()
  
  expect_error(sci_palette("a"), "number needs to be numeric")
  expect_error(sci_palette(length(res) + 1),
               paste0("there are only ", length(res), " colors set!"))
  
  # test length of output
  expect_equal(length(sci_palette(3)), 3)
})


# test structure ----------------------------------------------------------

test_that("output class is 'sci'", {
  res <- sci_palette()
  expect_equal(class(res), "sci")
  
}) 

