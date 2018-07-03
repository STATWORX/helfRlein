context("check existence of test files")

test_that("if for each function there is an testfile namend 'test_xxx'", {
  # get functions and tests
  function_files <- list.files("../../R/")
  test_files <- gsub("test_", "", list.files("../../tests/testthat/"))
  
  # remove this file from tests
  test_files <- setdiff(test_files, "tests.R")
  
  # check if all fucntions have a test
  expect_true(length(test_files) > 0)
  expect_equal(all(function_files %in% test_files), TRUE)
  
})
