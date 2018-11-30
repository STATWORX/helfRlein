context("check count_na")

test_that("example is right", {
  expect_equal(count_na(c(NA, NA, 1, NaN, 0)), 3)
  expect_equal(count_na(c(NA, NA, 1, NaN, "0")), 2)
  
})
