testthat::context("check get_network.R")


# error -------------------------------------------------------------------

testthat::test_that("path and files exists", {
  testthat::expect_error(get_network(dir = "/this/does/not/exists"),
               "/this/does/not/exists does not exists")
  testthat::expect_error(get_network(dir = ".", pattern = "notexistingpattern"),
               "no files with the given pattern")
})


# test scripts with functions ---------------------------------------------

testthat::test_that("example script works", {

  # this test includes the fact, that the print("foo_01") is counted
  # as a function
  test_scripts <- list(
    foo_01 = c("",
               "foo_01 <- function(y) {",
                 'print("Start foo_01")',
                 "# define sub functions",
                 "foo_02 <- function(x){",
                   "if (x < 100) {",
                     "print(x)",
                   "} else {",
                     'print("over 100")',
                   "} foo_03 <- function(x){print(2 * x)}",
                   "sapply(1:5, foo_03)",
                 "} # main part of foo_01",
                 "#}  main part of foo_01",
                 "foo_02(x = y)",
                 "foo_04(x = 10 * y)"),
    foo_04 = c("foo_04<-function(x){print(x)}"),
    foo_05 = c("foo_05<-function(x){NULL}")
  )

  test <- get_network(all_scripts = test_scripts)

  # functions then subfunctions
  res_names <- c("foo_01", "foo_04", "foo_05", "foo_02", "foo_03")
  res_matrix <- matrix(c(1, 1, 0, 1, 0,
                         0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0,
                         0, 0, 0, 0, 1,
                         0, 0, 0, 0, 0),
                       ncol = 5,
                       byrow = TRUE,
                       dimnames = list(res_names, res_names))
  res_data <- data.frame(res_matrix)

  res_g1 <- igraph::graph_from_adjacency_matrix(
    res_matrix,
    mode = c("directed"),
    weighted = TRUE,
    diag = TRUE,
    add.colnames = NULL,
    add.rownames = NA)

  igraph::V(res_g1)$label  <- res_names
  igraph::V(res_g1)$size   <- 10 * c(7 / 12, 1 / 3, 1 / 3, 1, 1 / 4)
  igraph::V(res_g1)$folder <- c(".", ".", ".", ".", ".")
  igraph::V(res_g1)$color  <- c(1, 1, 1, 1, 1)

  res <- list(matrix = res_data, igraph = res_g1)

  testthat::expect_equal(res$matrix, test$matrix)


})

testthat::test_that("special cases work", {

  # empty scripts
  test_scripts <- list(
    foo_01 = c("foo_01 <- function(){}"),
    foo_02 = c("# no function"),
    foo_03 = c("  ")
  )
  testthat::expect_warning(get_network(all_scripts = test_scripts),
                           "removing empty scritps: foo_02, foo_03")

  # no functions
  test_scripts <- list(
    foo_01 = c("print(\"over 100\")"),
    foo_02 = c("print(x)")
  )
  testthat::expect_warning(test <- get_network(all_scripts = test_scripts),
                 "no functions found")

  res <- list(matrix = NULL, igraph = NULL)
  testthat::expect_equal(res, test)

  # comments and function order
  test_scripts <- list(foo_01 = c("foo_01<-function(x){#print(x)}"),
                       foo_02 = c("foo_02<-function(x){",
                                  "#foo_01(x)",
                                  "}"))
  test <- get_network(all_scripts = test_scripts)

  res_names <- c("foo_01", "foo_02")
  res_matrix <- matrix(c(0, 0, 0, 0), ncol = 2,
                       dimnames = list(res_names, res_names))
  res_data <- data.frame(res_matrix)

  res_g1 <- igraph::graph_from_adjacency_matrix(
    res_matrix,
    mode = c("directed"),
    weighted = TRUE,
    diag = TRUE,
    add.colnames = NULL,
    add.rownames = NA)

  igraph::V(res_g1)$label  <- res_names
  igraph::V(res_g1)$size   <- 10 * c(2 / 3, 1)
  igraph::V(res_g1)$folder <- c(".", ".")
  igraph::V(res_g1)$color  <- c(1, 1)

  res <- list(matrix = res_data, igraph = res_g1)

  testthat::expect_equal(res$matrix, test$matrix)
})
