testthat::context("check statusbar")

testthat::test_that("error message", {
  testthat::expect_error(statusbar(run = c(1, 2), max.run = 20, width = 10L),
                         "run needs to be of length one!")

  testthat::expect_error(statusbar(run = 1, max.run = c(), width = 10L),
                         "max.run has length 0")


})


testthat::test_that("example output is right", {
  testthat::expect_output(statusbar(run = 2, max.run = 20, width = 10L),
                          "\\r \\[=         \\]   10\\.00% - 2")

  testthat::expect_output(statusbar(run = "b", max.run = letters[1:3], width = 10L),
                          "\\r \\[=======   \\]   66\\.67% - b")

  testthat::expect_output(statusbar(run = "b", max.run = letters[2], width = 10L),
                          "\\r \\[==========\\]  100\\.00% - b")
})
