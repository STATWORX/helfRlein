testthat::context("check object_size_in_env")

testthat::test_that("example output is right", {

  # setup an test environment
  this_env <- new.env()
  assign("Var1", 3, envir = this_env)
  assign("Var2", 1:1000, envir = this_env)
  assign("Var3", rep("test", 1000), envir = this_env)

  tmp <- object_size_in_env(env = this_env, unit = "B")
  res <- data.table::data.table(OBJECT = c("Var3", "Var2", "Var1"),
                                SIZE = c(8104, 4048, 56),
                                UNIT = "B")

  testthat::expect_equal(tmp, res)

})
