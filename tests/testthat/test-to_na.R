context("check to_na")

test_that("Inf is converted to NA", {
  x1 <- c(Inf, -Inf)
  expect_equal(to_na(x = x1),
               c(NA, NA))
})

test_that("NaN is converted to NA", {
  x1 <- c(NaN)
  expect_equal(to_na(x = x1),
               c(NA))
})

test_that("character is not converted to NA", {
  x1 <- c("a", NA)
  expect_equal(to_na(x = x1),
               c("a", NA))
})

test_that("input is a vector", {
  x1 <- matrix(1:3)
  expect_error(to_na(x = x1),
               "input must be a vector")
})
