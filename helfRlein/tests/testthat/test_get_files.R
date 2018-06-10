context("check get_files")

test_that("Handles wrong Inputs", {
  
  # Directory must exist
  dir <- "/this/directory/wont/exist"
  expect_error(get_files(dir, pattern = "test"),
               "Directory '/this/directory/wont/exist' doesn't exist")
  
  # Arguments must be character stings
  expect_error(get_files(".", pattern = 0L),
               "'pattern' must be a character string")
  expect_error(get_files(0L, pattern = 0L),
               "'dir' must be a character string")
  expect_error(get_files(0L, pattern = "0L"),
               "'dir' must be a character string")
  
})

