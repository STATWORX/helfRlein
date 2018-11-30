

read_files(files, FUN = readRDS)
#' read_files(files, FUN = readLines)
#' read_files(files, FUN = read.csv, sep = ";")
#' 
#' 

context("check read_files")

test_that("examples works for .csv, .rds and .txt", {
  
  # .csv
  testfiles <- list.files("inst/testdata", pattern = ".csv", full.names = TRUE)
  
  tmp1 <- read_files(testfiles, FUN = read.csv2, stringsAsFactors = FALSE)
  res1 <- data.table::data.table(x = 1:20,
                                 y = letters[1:20],
                                 z = rep(c(NA, 1), each = 10))
  expect_equal(tmp1, res1)
  
  # .rds
  testfiles <- list.files("inst/testdata", pattern = ".rds", full.names = TRUE)
  
  tmp2 <- read_files(testfiles, FUN = readRDS)
  res2 <- data.table::data.table(x = 1:20,
                                 y = letters[1:20],
                                 z = rep(c(NA, 1), each = 10))
  expect_equal(tmp2, res2)
  
  # .txt
  testfiles <- list.files("inst/testdata", pattern = ".txt", full.names = TRUE)
  
  tmp3 <- read_files(testfiles)
  res3 <- data.table::data.table(V1 = paste0(c(1:6), ". Zeile"))
  expect_equal(tmp3, res3)
  
})
