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

test_that("output example", {

  # Directory must exist
  dir <- system.file("test_filestructure", package = "helfRlein")
  # match R files
  expect_equal(get_files(dir = dir, pattern = "get_files"),
               "/folder_3/file_33.R")
  # match txt files
  expect_equal(get_files(dir = dir, pattern = "get_files", suffix = ".txt$"),
               "/folder_3/file_32.R.txt")
  # match all files
  expect_equal(get_files(dir = dir, pattern = "get_files", suffix = "."),
               c("/folder_3/file_32.R.txt", "/folder_3/file_33.R"))

  # match no file
  expect_equal(get_files(dir = dir, pattern = "not included"),
               character(0))

})
