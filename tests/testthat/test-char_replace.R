context("check char_replace")

test_that("example right output", {
  x <- " Élizàldë-González Strasse "
  # y <- c("äöü", "ÄÖÜ", "éè")
  
  expect_equal(char_replace(x,
                        to_lower = FALSE,
                        rm_space = FALSE,
                        rm_dash = FALSE,
                        to_underscore = FALSE),
               "Elizalde-Gonzalez Strasse")
  expect_equal(char_replace(x,
                        to_lower = TRUE,
                        rm_space = FALSE,
                        rm_dash = FALSE,
                        to_underscore = FALSE),
               "elizalde-gonzalez strasse")
  expect_equal(char_replace(x,
                        to_lower = FALSE,
                        rm_space = TRUE,
                        rm_dash = FALSE,
                        to_underscore = FALSE),
               "Elizalde-GonzalezStrasse")
  expect_equal(char_replace(x,
                        to_lower = FALSE,
                        rm_space = FALSE,
                        rm_dash = TRUE,
                        to_underscore = FALSE),
               "ElizaldeGonzalez Strasse")
  expect_equal(char_replace(x,
                        to_lower = FALSE,
                        rm_space = FALSE,
                        rm_dash = FALSE,
                        to_underscore = TRUE),
               "Elizalde_Gonzalez_Strasse")
  expect_equal(char_replace(x,
                        to_lower = TRUE,
                        rm_space = TRUE,
                        rm_dash = TRUE,
                        to_underscore = TRUE),
               "elizaldegonzalezstrasse")
})

test_that("existing warning", {
  
  x <- " Élizàldë-González Strasse "
  
  # Wanring for leading whitespaces
  expect_warning(char_replace(x,
                              to_lower = FALSE,
                              trim = FALSE,
                              rm_space = FALSE,
                              rm_dash = FALSE,
                              to_underscore = TRUE),
                 paste(
                   "Trimming is strongly recommended when using to_underscore.",
                   "Otherwise any leading or trailing whitespace characters will be",
                   "replaced with underscores as well."
                   )
                 )
  
  
})