context("check na_omitlist")


test_that("recursive is done correctly", {
  y <- list(NA, c(1, NA))
  tmp1 <- na_omitlist(y, recursive = TRUE)
  tmp2 <- na_omitlist(y, recursive = FALSE)
  
  expect_equal(tmp1, 1)
  expect_equal(tmp2, list(c(1,NA)))
})

test_that("if all but one is NA and recursive == TURE, the result is not a list",{
  tmp1 <- na_omitlist(list(NA, c(1, NA)), recursive = TRUE)
  tmp2 <- na_omitlist(list(NA, 1), recursive = TRUE)
  tmp3 <- na_omitlist(list(NA, c(1, NA)), recursive = FALSE)
  tmp4 <- na_omitlist(list(NA, 1), recursive = FALSE)
  
  expect_type(tmp1, "double")
  expect_type(tmp2, "double")
  expect_type(tmp3, "list")
  expect_type(tmp4, "list")
  
})
