context("check clean_gc.R")

test_that("verbose is working", {
  out <- capture_output(clean_gc(verbose = FALSE), print = FALSE)
  expect_equal(out, "")
})
