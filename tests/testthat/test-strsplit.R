context("check strsplit")


# errors and warnings -----------------------------------------------------


test_that("type is remove, after, before or between", {
  x <- c("3D/MON&SUN")
  expect_error(strsplit(x, split = "/", type = ""),
               "type must be remove, after, before or between!")
  expect_error(strsplit(x, split = "/", type = 2),
               "type must be remove, after, before or between!")
  expect_error(strsplit(x, split = "/", type = NA),
               "type must be remove, after, before or between!")
})

test_that("length of split is right", {
  x <- c("3D/MON&SUN")
  expect_warning(strsplit(x, split = c("/", "M"), type = "remove"),
               "there are multiple splits - taking only the first one")
  expect_error(strsplit(x, split = c("/"), type = "between"),
                 "split need no have length two!")
})


# examples ----------------------------------------------------------------


test_that("examples give correct output with type", {
  x <- c("3D/MON&SUN")
  
  expect_equal(strsplit(x, "[/&]"),
               list(c("3D",  "MON", "SUN")))
  expect_equal(strsplit(x, "[/&]", type = "before"),
               list(c("3D",  "/MON", "&SUN")))
  expect_equal(strsplit(x, "[/&]", type = "after"),
               list(c("3D/",  "MON&", "SUN")))
  expect_equal(strsplit(x, c("N", "&"), type = "between"),
               list(c("3D/MON", "&SUN")))
  
})

test_that("examples for between are correct", {
  x <- c("3D/MON&SUN 2D/MON&SUN")
  expect_equal(strsplit(x, split("/", "M")),
               list(c("3D", "MON&SUN 2D", "MON&SUN")))
  
  x <- c("3D/MON&SUN", "2D/MON&SUN")
  expect_equal(strsplit(x, split("/", "M")),
               list(c("3D", "MON&SUN"), c("2D", "MON&SUN")))
  
})

