testthat::context("check na_omitlist")


testthat::test_that("recursive is done correctly", {
  y <- list(NA, c(1, NA))
  tmp1 <- na_omitlist(y, recursive = TRUE)
  tmp2 <- na_omitlist(y, recursive = FALSE)

  testthat::expect_equal(tmp1, 1)
  testthat::expect_equal(tmp2, list(c(1, NA)))
})
testthat::test_that("if all but one is NA and recursive == TURE, result is not a list", {
  tmp1 <- na_omitlist(list(NA, c(1, NA)), recursive = TRUE)
  tmp2 <- na_omitlist(list(NA, 1), recursive = TRUE)
  tmp3 <- na_omitlist(list(NA, c(1, NA)), recursive = FALSE)
  tmp4 <- na_omitlist(list(NA, 1), recursive = FALSE)

  testthat::expect_type(tmp1, "double")
  testthat::expect_type(tmp2, "double")
  testthat::expect_type(tmp3, "list")
  testthat::expect_type(tmp4, "list")
})

testthat::test_that("example works as specified", {
  y <- list(c(1:3), letters[1:4], NA, c(1, NA), list(c(5:6, NA), NA, "A"))
  tmp1 <- na_omitlist(y, recursive = FALSE)
  tmp2 <- na_omitlist(y, recursive = TRUE)

  res1 <- list(c(1:3), letters[1:4], c(1, NA), list(c(5:6, NA), NA, "A"))
  res2 <- list(c(1:3), letters[1:4], c(1), list(c(5:6), "A"))

  testthat::expect_equal(tmp1, res1)
  testthat::expect_equal(tmp2, res2)
})
