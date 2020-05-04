# helfRlein <img src="img/helfRlein.png" width=170 align="right" />
[![CircleCI](https://circleci.com/gh/STATWORX/helfRlein.svg?style=svg)](https://circleci.com/gh/STATWORX/helfRlein)

# r cmd check
master-brach: ![master-brach](https://github.com/STATWORX/helfRlein/workflows/R-CMD-check/badge.svg?branch=master)
dev-branch: ![dev-branch](https://github.com/STATWORX/helfRlein/workflows/R-CMD-check/badge.svg?branch=dev)

# lints
![master-lints](https://github.com/STATWORX/helfRlein/workflows/lints/badge.svg?branch=master)
![dev-lints](https://github.com/STATWORX/helfRlein/workflows/lints/badge.svg?branch=dev)

# test coverage
![master-test-coverage](https://github.com/STATWORX/helfRlein/workflows/test-coverage/badge.svg?branch=master)
![dev-test-coverage](https://github.com/STATWORX/helfRlein/workflows/test-coverage/badge.svg?branch=dev)
----

## Overview

This package contains a collection of R helper functions. There are three main topics:

- independent and stand alone functions (eg. [burglr](https://www.statworx.com/de/blog/burglr-stealing-code-from-the-web/) or [dive](http://www.statworx.com/de/blog/dive-the-debugging-function-you-deserve/))

- general helper functions that ease our programing life

- functions that ease our daily work and projects



## Installation

``` r
# install.packages("devtools")
devtools::install_github("STATWORX/helfRlein")
```



## List of functions

### stand alone functions

- `burglr()` 
  A functions to source code from the web. You can find a detailed introduction to this function [here](https://www.statworx.com/de/blog/burglr-stealing-code-from-the-web/).

- `dive()`
  A debugging function for that will sort out the parameters for you. You can use it for example with Sublime. You can find a detailed introduction to this function [here](https://www.statworx.com/de/blog/dive-the-debugging-function-you-deserve/).



### general helper functions

- `checkdir()`
  Combines `file.exists()` and `dir.create()`.

- `clean_gc()`
  A function that calls `gc()` numerous times.

- `count_na()`
  A functions that returns the number of missing values.

- `evenstrings()`
  This function reduces and cuts a given string into parts with a fixed length.

- `get_sequence()`
  A function that returns start and end indices that indicates where a given pattern occurs.

- `intersect2()`
  This function returns the intersect between multiple vectors.

- `multiplot()`
  A function to combine different ggplots into one plot.

- `na_omitlist()`
  A function to remove missing values from a list.

- `%nin%`
  A *not in* operator.

- `read_files()`
  Reads in a list of files and combines them into one *data.table*.

- `statusbar()`
  A progress bar for for-loops.

- `strsplit()`
  This functions uses adds the possibility to keep the delimiter after, before or between a given split.

- `to_na()`
  Takes out `NaN` and `Inf` values and replaces them with `NA`.

- `trim()`
  Removes leading and or trailing whitespaces.

  ​

### project functions

- `get_files()`
  A functions for finding patterns in R Files.
- `get_network()` 
  A function that visualises the connections between UDF within your project. You can find a detailed introduction to this function [here](https://github.com/STATWORX/blog/tree/master/flowchart).
- `object_size_in_env()`
  Lists all objects with their size in a given environment.
- `print_fs()`
  This function prints the folder and file structure of a given path.
- `sci_palette()`
  A functions that shows STATWORX's CI colours. 
- `statworx_palette()`
  This functions creates a colour palette based on our CI colours.

