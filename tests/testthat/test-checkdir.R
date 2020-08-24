context("check checkdir")

test_that("NA, NULL is handeld right", {

  old_lang <- Sys.getenv("LANG")

  Sys.setenv(LANG = "en")

  on.exit(Sys.setenv(LANG = old_lang))

  expect_error(checkdir(path = NA, recursive = FALSE),
               "invalid 'path' argument")
  expect_error(checkdir(path = NULL, recursive = FALSE),
               "argument is of length zero")

})

test_that("existing warning", {

  testdir <- "temp_folder1_test/"
  expect_equal(checkdir(testdir), TRUE)
  expect_equal(checkdir(testdir, verbose = FALSE), FALSE)
  expect_warning(checkdir(testdir, verbose = TRUE),
                 paste0(testdir, " - already exists"))


  # clean up
  if (file.exists(file.path(testdir))) {
    unlink(testdir, recursive = TRUE)
  } else {
    stop("folder creation failed!")
  }
})


test_that("recursive is working", {

  testfile <- "temp_folder1_test/temp_folder2.test"
  expect_equal(checkdir(testfile), TRUE)
  # clean up
  if (file.exists(testfile)) {
    unlink(dirname(testfile), recursive = TRUE)
  } else {
    stop("folder creation failed!")
  }

})
