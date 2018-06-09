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
  expect_warning(print_fs(path = ".", depth = -2),
                 "depth was negative, set to 2")
})
