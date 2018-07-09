# script to create the DESCRIPTION file

#install.packages("usethis")
library(usethis)

# Modify the description ----------------------------------------------
use_mit_license("My Name")
#> ✔ Setting License field in DESCRIPTION to 'MIT + file LICENSE'
#> ✔ Writing 'LICENSE.md'
#> ✔ Adding '^LICENSE\\.md$' to '.Rbuildignore'
#> ✔ Writing 'LICENSE'

use_package("MASS", "Suggests")
#> ✔ Adding 'MASS' to Suggests field in DESCRIPTION
#> ● Use `requireNamespace("MASS", quietly = TRUE)` to test if package is installed
#> ● Then use `MASS::fun()` to refer to functions.

use_dev_package("callr")
#> ✔ Adding 'callr' to Imports field in DESCRIPTION
#> ● Refer to functions with `callr::fun()`
#> ✔ Adding 'r-lib/callr' to DESCRIPTION Remotes

# Set up various packages ---------------------------------------------
use_roxygen_md()
#> ✔ Setting Roxygen field in DESCRIPTION to 'list(markdown = TRUE)'
#> ✔ Setting RoxygenNote field in DESCRIPTION to '6.0.1.9000'
#> ● Re-document

use_rcpp()
#> ✔ Adding 'Rcpp' to LinkingTo field in DESCRIPTION
#> ✔ Adding 'Rcpp' to Imports field in DESCRIPTION*
#> ✔ Creating 'src/'
#> ✔ Adding '*.o', '*.so', '*.dll' to 'src/.gitignore'
#> ● Include the following roxygen tags somewhere in your package
#>   #' @useDynLib mypkg, .registration = TRUE
#>   #' @importFrom Rcpp sourceCpp
#>   NULL
#> ● Run document()

use_revdep()
#> ✔ Creating 'revdep/'
#> ✔ Adding '^revdep$' to '.Rbuildignore'
#> ✔ Adding 'checks', 'library', 'checks.noindex', 'library.noindex', 'data.sqlite', '*.html' to 'revdep/.gitignore'
#> ✔ Writing 'revdep/email.yml'
#> ● Run checks with `revdepcheck::revdep_check(num_workers = 4)`

# Set up other files -------------------------------------------------
use_readme_md()
#> ✔ Writing 'README.md'

use_news_md()
#> ✔ Writing 'NEWS.md'

use_test("my-test")
#> ✔ Adding 'testthat' to Suggests field in DESCRIPTION
#> ✔ Creating 'tests/testthat/'
#> ✔ Writing 'tests/testthat.R'
#> ✔ Writing 'tests/testthat/test-my-test.R'

x <- 1
y <- 2
use_data(x, y)
#> ✔ Creating 'data/'
#> ✔ Saving x to data/x.rda
#> ✔ Saving y to data/y.rda

# Use git ------------------------------------------------------------
use_git()
#> ✔ Initialising Git repo
#> ✔ Adding '.Rhistory', '.RData', '.Rproj.user' to './.gitignore'