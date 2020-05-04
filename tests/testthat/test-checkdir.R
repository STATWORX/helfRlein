context("check checkdir")

test_that("NA, NULL is handeld right", {

  expect_error(checkdir(path = NA, recursive = FALSE),
               "invalid 'file' argument")
  expect_error(checkdir(path = NULL, recursive = FALSE),
               "invalid 'file' argument")

})

test_that("existing warning", {

  testfile <- "temp_folder1_test/"
  expect_equal(checkdir(testfile), TRUE)
  expect_equal(checkdir(testfile, verbose = FALSE), FALSE)
  expect_warning(checkdir(testfile, verbose = TRUE),
                 paste0(testfile, " - already exists"))


  # clean up
  if (file.exists(testfile)) {
    unlink(dirname(testfile), recursive = TRUE)
  } else {
    stop("folder creation failed!")
  }
})


test_that("recursive is working", {

  testfile <- "temp_folder1_test/temp_folder2_test"
  expect_equal(checkdir(testfile), TRUE)
  # clean up
  if (file.exists(testfile)) {
    unlink(dirname(testfile), recursive = TRUE)
  } else {
    stop("folder creation failed!")
  }

})
