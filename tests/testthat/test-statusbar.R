context("check statusbar")

test_that("error message", {
  expect_error(statusbar(run = c(1,2), max.run = 20, percent.max = 10L),
               "run needs to be of length one!")
  
  expect_error(statusbar(run = 1, max.run = c(), percent.max = 10L),
               "max.run has length 0")
  
  
})

test_that("example output is right", {
  expect_output(statusbar(run = 2, max.run = 20, percent.max = 10L),
                "\\n \\[=         \\]   10\\.00% - 2")
})
