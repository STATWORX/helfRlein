context("check get_files")

test_that("Directory must exist", {
  dir <- "/this/directory/wont/exist"
  expect_error(get_files(dir, pattern = "test"),
               "doesn't exist")
})