testthat::context("check to_na")

testthat::test_that("Inf is converted to NA", {
  x1 <- c(Inf, -Inf)
  testthat::expect_equal(to_na(x = x1),
               c(NA, NA))
})

testthat::test_that("NaN is converted to NA", {
  x1 <- c(NaN)
  testthat::expect_equal(to_na(x = x1),
               c(NA))
})

testthat::test_that("character is not converted to NA", {
  x1 <- c("a", NA)
  testthat::expect_equal(to_na(x = x1),
               c("a", NA))
})

testthat::test_that("input is a vector", {
  x1 <- matrix(1:3)
  testthat::expect_error(to_na(x = x1),
               "input must be a vector")
})
