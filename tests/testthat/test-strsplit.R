testthat::context("check strsplit")


# errors and warnings -----------------------------------------------------


testthat::test_that("type is remove, after, before or between", {
  x <- c("3D/MON&SUN")
  testthat::expect_error(strsplit(x, split = "/", type = ""),
               "type must be remove, after, before or between!")
  testthat::expect_error(strsplit(x, split = "/", type = 2),
               "type must be remove, after, before or between!")
  testthat::expect_error(strsplit(x, split = "/", type = NA),
               "type must be remove, after, before or between!")
})

testthat::test_that("length of split is right", {
  x <- c("3D/MON&SUN")
  testthat::expect_warning(strsplit(x, split = c("/", "M"), type = "remove"),
               "there are multiple splits - taking only the first one")
  testthat::expect_error(strsplit(x, split = c("/"), type = "between"),
                 "split need no have length two!")
})



# examples ----------------------------------------------------------------

# has the same behavior as base::strsplit, needs more thinking, if this is ok.
# testthat::test_that("empty inputs are handeled", {
#   # check x is "", NA
#
#   testthat::expect_equal(strsplit(x, split = "a", type = "before"),
#                          list(x))
#   testthat::expect_equal(strsplit(x, split = "a", type = "after"),
#                          list(x))
#   testthat::expect_equal(strsplit(x, split = c("a", "b"), type = "between"),
#                          list(x))
#
#
#   # check x is NULL
#
#   testthat::expect_equal(strsplit(x, split = "a", type = "before"),
#                          list(x))
#   testthat::expect_equal(strsplit(x, split = "a", type = "after"),
#                          list(x))
#   testthat::expect_equal(strsplit(x, split = c("a", "b"), type = "between"),
#                          list(x))
#
#
# })

testthat::test_that("examples give correct output with type", {
  x <- c("3D/MON&SUN")

  testthat::expect_equal(strsplit(x, "[/&]"),
               list(c("3D",  "MON", "SUN")))
  testthat::expect_equal(strsplit(x, "[/&]", type = "before"),
               list(c("3D",  "/MON", "&SUN")))
  testthat::expect_equal(strsplit(x, "[/&]", type = "after"),
               list(c("3D/",  "MON&", "SUN")))
  testthat::expect_equal(strsplit(x, c("N", "&"), type = "between"),
               list(c("3D/MON", "&SUN")))

})

testthat::test_that("examples for between are correct", {
  x <- c("3D/MON&SUN 2D/MON&SUN")
  testthat::expect_equal(strsplit(x, split("/", "M")),
               list(c("3D", "MON&SUN 2D", "MON&SUN")))

  x <- c("3D/MON&SUN", "2D/MON&SUN")
  testthat::expect_equal(strsplit(x, split("/", "M")),
               list(c("3D", "MON&SUN"), c("2D", "MON&SUN")))

})
