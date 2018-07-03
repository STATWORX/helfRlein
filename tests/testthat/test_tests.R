context("check existence of test files")

test_that("if for each function there is an testfile namend 'test_xxx'", {
  # for debugging since now .. does not work
  # function_files <- list.files("R/")
  # test_files <- gsub("test_", "", list.files("tests/testthat/"))
  
  # get functions and tests
  function_files <- list.files("../../R/")
  test_files <- gsub("test_", "", list.files("../../tests/testthat/"))
  
  # remove exceptions from tests
  package_files <- c("tests.R", "helfRlein.R")
  exceptions <- c("burglr.R", "clean_gc.R", "get_network.R",
                  "multiplot.R", "dive.R", "helfRlein.R")
  function_files <- setdiff(function_files, c(exceptions, package_files))
  
  # check if all fucntions have a test
  if (length(exceptions) != 0) {
    warning("there are still test exceptions!")
  }
  expect_equal(all(function_files %in% test_files), TRUE)
  
})
