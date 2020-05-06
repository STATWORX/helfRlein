context("check na_omitlist")


test_that("recursive is done correctly", {
  y <- list(NA, c(1, NA))
  tmp1 <- na_omitlist(y, recursive = TRUE)
  tmp2 <- na_omitlist(y, recursive = FALSE)

  expect_equal(tmp1, 1)
  expect_equal(tmp2, list(c(1, NA)))
})
test_that("if all but one is NA and recursive == TURE, result is not a list", {
  tmp1 <- na_omitlist(list(NA, c(1, NA)), recursive = TRUE)
  tmp2 <- na_omitlist(list(NA, 1), recursive = TRUE)
  tmp3 <- na_omitlist(list(NA, c(1, NA)), recursive = FALSE)
  tmp4 <- na_omitlist(list(NA, 1), recursive = FALSE)

  expect_type(tmp1, "double")
  expect_type(tmp2, "double")
  expect_type(tmp3, "list")
  expect_type(tmp4, "list")
})

test_that("example works as specified", {
  y <- list(c(1:3), letters[1:4], NA, c(1, NA), list(c(5:6, NA), NA, "A"))
  tmp1 <- na_omitlist(y, recursive = FALSE)
  tmp2 <- na_omitlist(y, recursive = TRUE)

  res1 <- list(c(1:3), letters[1:4], c(1, NA), list(c(5:6, NA), NA, "A"))
  res2 <- list(c(1:3), letters[1:4], c(1), list(c(5:6), "A"))

  expect_equal(tmp1, res1)
  expect_equal(tmp2, res2)
})
