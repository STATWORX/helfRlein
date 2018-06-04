context("check print_fs")


test_that("input path has the right format", {
  expect_error(print_fs(path = 1),
               "path must be a character")
  expect_error(print_fs(path = c(".", ".")),
               "path must have length one")
  expect_error(print_fs(path = ""),
               "path does not exist")
})


test_that("silent usage is right", {
  tmp1 <- print_fs(path = ".", silent = TRUE)
  tmp2 <- print_fs(path = ".", silent = FALSE)
  
  expect_null(tmp2)
  expect_type(tmp1,  "environment")
})
