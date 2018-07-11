context("test-get_network.R")


# error -------------------------------------------------------------------

test_that("path and files exists", {
  expect_error(get_network(dir = "/this/does/not/exists"),
               "/this/does/not/exists does not exists")
  print(getwd())
  expect_error(get_network(dir = ".", pattern = "notexistingpattern"),
               "no files with the given pattern")
})
