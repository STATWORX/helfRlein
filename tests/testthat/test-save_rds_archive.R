context("Test save_rds_archive")

test_that("'file' must be a non-empty character", {

  expect_error(save_rds_archive(5, file = ""),
               "'file' must be a non-empty character string")

  expect_error(save_rds_archive(5, file = 5),
               "'file' must be a non-empty character string")

  con <- url("https://www.statworx.com/de/")

  expect_error(save_rds_archive(5, file = con),
               "'file' must be a non-empty character string")

  close(con)

})

test_that("'archive_dir_path' cannot be null", {

  expect_error(save_rds_archive(5, file = "test.RDS", archive_dir_path = ""),
               "must supply a directory name to 'archive_dir_path' if not NULL")

})



test_that("'archive' and 'with_time' must be bools", {

  expect_warning(save_rds_archive(5, file = "temp.RDS", archive = 0),
                 "'archive' is not set to a boolean - will use default")

  expect_warning(save_rds_archive(5, file = "temp.RDS", with_time = 1),
                 "'with_time' is not set to a boolean - will use default")

})


test_that("if file name contains multiple 'RDS', only the last one is replaced with suffix", {

  temp <- "temp_rds_Rds.rds"

  saveRDS(10, file = temp)
  save_rds_archive(20, file = temp)

  expect_true(file.exists(paste0(tools::file_path_sans_ext(temp),
                                 "_ARCHIVED_on_",
                                 Sys.Date(),
                                 ".",
                                 tools::file_ext(temp))))

})

test_that("creation of archive dir works as expected", {

  temp <- "temp.RDS"
  my_path <- "archives/rds_files/dump"

  saveRDS(10, file = temp)

  expect_message(save_rds_archive(object = 20, file = temp, archive_dir_path = my_path),
                 "Created missing archive directory")

  archived_version <- readRDS(paste0(my_path, "/",
                                     tools::file_path_sans_ext(temp),
                                     "_ARCHIVED_on_",
                                     Sys.Date(),
                                     ".",
                                     tools::file_ext(temp)))

  updated_version <- readRDS("temp.RDS")

  expect_true(archived_version == 10)
  expect_true(updated_version == 20)

})

test_that("existing archived copies will be overwritten", {

  temp <- "temp_copy.RDS"

  saveRDS(5, temp)
  save_rds_archive(10, temp)

  expect_warning(save_rds_archive(object = 20, file = temp),
                 "Archived copy already exists - will overwrite!")

  overwritten_copy <- readRDS(paste0(tools::file_path_sans_ext(temp),
                                     "_ARCHIVED_on_",
                                     Sys.Date(),
                                     ".",
                                     tools::file_ext(temp)))

  current <- readRDS(temp)

  expect_true(overwritten_copy == 10)
  expect_true(current == 20)


})

test_that("everything goes as expected if file does not exist", {

  temp1 <- "temp123.RDS"

  expect_warning(save_rds_archive(500, temp1, archive = TRUE),
                 NULL)

  temp2 <- "temp234.RDS"
  expect_warning(save_rds_archive(500, temp2, archive = FALSE),
                 NULL)


})

