testthat::context("check clean_gc.R")

testthat::test_that("verbose is working", {
  out <- testthat::capture_output(clean_gc(verbose = FALSE), print = FALSE)
  testthat::expect_equal(out, "")
})
