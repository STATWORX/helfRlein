testthat::context("check count_na")

testthat::test_that("example is correct", {
  testthat::expect_equal(count_na(c(NA, NA, 1, NaN, 0)), 3)
  testthat::expect_equal(count_na(c(NA, NA, 1, NaN, "0")), 2)
})

testthat::test_that("mean is correct", {
  testthat::expect_equal(count_na(c(NA, NA, 1, NaN, 0), mean = TRUE), 0.6)
})
