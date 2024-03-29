testthat::context("check print_fs")


testthat::test_that("input path has the right format", {
  testthat::expect_error(print_fs(path = 1),
               "path must be a character")
  testthat::expect_error(print_fs(path = c(".", ".")),
               "path must have length one")
  testthat::expect_error(print_fs(path = ""),
               "path does not exist")
})

testthat::test_that("path is positive numeric or integer", {
  testthat::expect_error(print_fs(path = ".", depth = "a"),
               "depth must be a positive integer")
  testthat::expect_error(print_fs(path = ".", depth = NA),
               "depth must be a positive integer")
  testthat::expect_error(print_fs(path = ".", depth = NULL),
               "depth must be a positive integer")
  out1 <- testthat::capture_output(
    testthat::expect_warning(print_fs(path = ".", depth = -2),
                 "depth was negative, set to 2")
  )
})

testthat::test_that("output is correct", {

  datapath <- system.file("test_filestructure", package = "helfRlein")

  # null value
  out2 <- testthat::capture_output(testthat::expect_null(print_fs(path = datapath)))
  # string vector
  res_1 <- c("test_filestructure\n",
             " |--folder_1\n",
             " | o--file_1.txt\n",
             " |--folder_2\n",
             " | |--subfolder_1\n",
             " | | |--file_211.txt\n",
             " | | o--file_212.txt\n",
             " | |--subfolder_2\n",
             " | | |--file_221.txt\n",
             " | | o--file_222.txt\n",
             " | o--file_2.txt\n",
             " |--folder_3\n",
             " | |--file_31.txt\n",
             " | |--file_32.R.txt\n",
             " | o--file_33.R\n",
             " o--file_0.txt\n")
  testthat::expect_equal(print_fs(path = datapath,
                        return = TRUE,
                        print = FALSE,
                        depth = 4),
               res_1)
})
