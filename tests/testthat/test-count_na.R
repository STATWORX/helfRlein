context("check count_na")

test_that("example is correct", {
  expect_equal(count_na(c(NA, NA, 1, NaN, 0)), 3)
  expect_equal(count_na(c(NA, NA, 1, NaN, "0")), 2)
})

test_that("mean is correct", {
  expect_equal(count_na(c(NA, NA, 1, NaN, 0), mean = TRUE), 0.6)
})

