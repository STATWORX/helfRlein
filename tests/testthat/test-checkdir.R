testthat::context("check checkdir")

testthat::test_that("NA, NULL is handeld right", {

  testthat::expect_error(checkdir(path = NA, recursive = FALSE),
               "path is NA or NULL")
  testthat::expect_error(checkdir(path = NULL, recursive = FALSE),
               "path is NA or NULL")

})

testthat::test_that("existing warning", {

  testdir <- "temp_folder1_test/"
  testthat::expect_equal(checkdir(testdir), TRUE)
  testthat::expect_equal(checkdir(testdir, verbose = FALSE), FALSE)
  testthat::expect_warning(checkdir(testdir, verbose = TRUE),
                 paste0(testdir, " - already exists"))


  # clean up
  if (file.exists(file.path(testdir))) {
    unlink(testdir, recursive = TRUE)
  } else {
    stop("folder creation failed!")
  }
})


testthat::test_that("recursive is working", {

  testfile <- "temp_folder1_test/temp_folder2.test"
  testthat::expect_equal(checkdir(testfile), TRUE)
  # clean up
  if (file.exists(testfile)) {
    unlink(dirname(testfile), recursive = TRUE)
  } else {
    stop("folder creation failed!")
  }

})
