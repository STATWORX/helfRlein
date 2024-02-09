testthat::context("check intersect2")


testthat::test_that("if the input has diffrent formats", {
  testthat::expect_warning(intersect2(c(1:3), c(1:4), c("2", "1")),
                 "different input types will be converted")
})

testthat::test_that("the output is right for same input types", {
  testthat::expect_equal(intersect2(c(1:3), c(1:4), c(1:2)),
               c(1, 2))
})

testthat::test_that("list and vector input", {
  testthat::expect_warning(tmp1 <- intersect2(list(c(1:3), c(1:4)),
                     list(c(1:2), c(1:3)),
                     c(1:2)),
                 "different input types will be converted")
  testthat::expect_equal(tmp1, c(1, 2))
})
