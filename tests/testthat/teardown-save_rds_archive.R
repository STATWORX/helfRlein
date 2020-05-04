## TEARDOWN FILE
## Clean up RDS files which were saved in 'test-save_rds_archive.R'

## ATTENTION: Do NOT run/source isolated! Only works within testthat::test_dir()
## and related calls

## files in test/teststhat/teardown-xyz.R are run after all tests are complete;
## use these to clean up any global changes made by the setup files.

# get all RDS files, recursively, ignore case
to_remove <- grep(pattern = ".rds$",
                  x = list.files(recursive = TRUE),
                  ignore.case = TRUE,
                  value = TRUE)

# to recursively remove dirs, remove everything after first "/"
to_remove <- gsub(pattern = "/.*", replacement = "", x = to_remove)

# recursively remove files and dirs
unlink(to_remove,
       recursive = TRUE)

rm(to_remove)
