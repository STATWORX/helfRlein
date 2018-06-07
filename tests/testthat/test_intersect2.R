context("check intersect2")


test_that("there are at least two inputs", {
  expect_error(intersect2(c(1:4)),
               "cannot evaluate intersection fewer than 2 arguments")
})

test_that("if the input has diffrent formats", {
  expect_warning(intersect2(c(1:3), c(1:4), c("2", "1")),
                 "different input types will be converted")
})

test_that("the output is right for same input types", {
  expect_equal(intersect2(c(1:3), c(1:4), c(1:2)),
               c(1,2))
})


