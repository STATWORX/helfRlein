testthat::context("check nin")

testthat::test_that("example output is right", {

  testthat::expect_equal(c(1, 2, 3, 4) %nin% c(1, 2, 5),
               c(FALSE, FALSE, TRUE, TRUE))

})
