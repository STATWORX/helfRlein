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
               "_Elizalde_Gonzalez_Strasse_")
  expect_equal(char_replace(x,
                        to_lower = TRUE,
                        rm_space = TRUE,
                        rm_dash = TRUE,
                        to_underscore = TRUE),
               "elizaldegonzalezstrasse")
})