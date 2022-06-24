testthat::context("check char_replace")

testthat::test_that("example right output", {
  x <- " Élizàldë-González Strasse  "

  testthat::expect_equal(char_replace(x,
                        to_lower = FALSE,
                        rm_space = FALSE,
                        rm_dash = FALSE,
                        to_underscore = FALSE),
               "Elizalde-Gonzalez Strasse")
  testthat::expect_equal(char_replace(x,
                        to_lower = TRUE,
                        rm_space = FALSE,
                        rm_dash = FALSE,
                        to_underscore = FALSE),
               "elizalde-gonzalez strasse")
  testthat::expect_equal(char_replace(x,
                        to_lower = FALSE,
                        rm_space = TRUE,
                        rm_dash = FALSE,
                        to_underscore = FALSE),
               "Elizalde-GonzalezStrasse")
  testthat::expect_equal(char_replace(x,
                        to_lower = FALSE,
                        rm_space = FALSE,
                        rm_dash = TRUE,
                        to_underscore = FALSE),
               "ElizaldeGonzalez Strasse")
  testthat::expect_equal(char_replace(x,
                        to_lower = FALSE,
                        rm_space = FALSE,
                        rm_dash = FALSE,
                        to_underscore = TRUE),
               "Elizalde_Gonzalez_Strasse")
  testthat::expect_equal(char_replace(x,
                        to_lower = TRUE,
                        rm_space = TRUE,
                        rm_dash = TRUE,
                        to_underscore = TRUE),
               "elizaldegonzalezstrasse")
})

testthat::test_that("existing warning", {

  x <- " Élizàldë-González Strasse "

  # Wanring for leading whitespaces
  testthat::expect_warning(char_replace(x,
                              to_lower = FALSE,
                              trim = FALSE,
                              rm_space = FALSE,
                              rm_dash = FALSE,
                              to_underscore = TRUE),
                 paste(
                   "Trimming is strongly recommended when using to_underscore.",
                   "Otherwise any leading or trailing whitespace characters",
                   "will be replaced with underscores as well."
                   )
                 )

  testthat::expect_warning(char_replace(x,
                              to_lower = FALSE,
                              trim = FALSE,
                              rm_space = TRUE,
                              rm_dash = FALSE,
                              to_underscore = FALSE),
                 "trim = FALSE is ignored because of rm_sapce = TRUE")

})
