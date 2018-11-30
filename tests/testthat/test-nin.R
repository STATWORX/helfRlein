context("check nin")

test_that("example output is right", {
  
  expect_equal(c(1,2,3,4) %nin% c(1,2,5),
               c(FALSE, FALSE, TRUE, TRUE))
  
})
