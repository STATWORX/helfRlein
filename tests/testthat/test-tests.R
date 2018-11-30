context("check existence of test files")

test_that("if for each function there is an testfile namend 'test-xxx'", {
  # for debugging since .. does not work here
  # function_files <- list.files("R/")
  # test_files <- gsub("test-", "", list.files("tests/testthat/"))
  
  # get functions and tests
  function_files <- list.files("../../R/")
  test_files <- gsub("test-", "", list.files("../../tests/testthat/"))
  
  # remove exceptions from tests
  package_files <- c("tests.R", "helfRlein.R")
  exceptions <- c("burglr.R", "multiplot.R", "dive.R", "methods.sci.R")
  if (length(intersect(exceptions, test_files)) != 0) {
    warning("there are exceptions for files that have a test: ", 
            paste0(intersect(exceptions, test_files), collapse = ", "))
  }
  
  function_files <- setdiff(function_files, c(exceptions, package_files))
  
  # check if all fucntions have a test
  if (length(exceptions) != 0) {
    warning(paste0("there are still ", length(exceptions),
                   " test exceptions: ",
                   paste0(exceptions, collapse = ", ")))
  }
  
  indx <- !function_files %in% test_files
  if (sum(indx) > 1) {
    warning(paste0("there are still ", sum(indx),
                   " tests missing: ",
                   paste0(function_files[indx], collapse = ", ")))
  }
  if (sum(indx) == 1) {
    warning(paste0("there is still ", sum(indx),
                   " test missing: ",
                   paste0(function_files[indx], collapse = ", ")))
  }
  
  expect_equal(sum(indx), 0)
  
})
