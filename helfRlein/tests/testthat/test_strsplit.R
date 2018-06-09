context("check strsplit")

test_that("type is remove, after or before", {
  x <- c("3D/MON&SUN")
  expect_error(strsplit(x, split = "/", type = ""),
               "type must be remove, after or before!")
  expect_error(strsplit(x, split = "/", type = 2),
               "type must be remove, after or before!")
  expect_error(strsplit(x, split = "/", type = NA),
               "type must be remove, after or before!")
})


test_that("examples give correct output with type", {
  x <- c("3D/MON&SUN")
  
  expect_equal(strsplit(x, "[/&]"),
               list(c("3D",  "MON", "SUN")))
  expect_equal(strsplit(x, "[/&]", type = "before"),
               list(c("3D",  "/MON", "&SUN")))
  expect_equal(strsplit(x, "[/&]", type = "after"),
               list(c("3D/",  "MON&", "SUN")))
  
})

