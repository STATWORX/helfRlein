context("check str_even")

test_that("example right output", {
  x <- "Élizàldë-González Strasse"
  # y <- c("äöü", "ÄÖÜ", "éè")
  
  expect_equal(str_even(input = x),
               "elizalde_gonzalez_strasse")
})