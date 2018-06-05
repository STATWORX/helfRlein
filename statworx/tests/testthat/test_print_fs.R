context("check print_fs")


test_that("input path has the right format", {
  expect_error(print_fs(path = 1),
               "path must be a character")
  expect_error(print_fs(path = c(".", ".")),
               "path must have length one")
  expect_error(print_fs(path = ""),
               "path does not exist")
})

test_that("path is positive numeric or integer", {
  expect_error(print_fs(path = ".", depth = "a"),
               "depth must be a positive integer")
  expect_error(print_fs(path = ".", depth = NA),
               "depth must be a positive integer")
  expect_error(print_fs(path = ".", depth = NULL),
               "depth must be a positive integer")
  expect_warning(print_fs(path = ".", depth = -2, silent = TRUE),
                 "depth was negative, set to 2")
})


test_that("silent usage is right", {
  tmp1 <- print_fs(path = ".", silent = TRUE)
  # capture printing output
  capture_output(tmp2 <- print_fs(path = ".", silent = FALSE))
  
  expect_null(tmp2)
  expect_type(tmp1,  "environment")
})
