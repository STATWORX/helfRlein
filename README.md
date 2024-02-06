# helfRlein - 1.4.2 <img src="img/helfRlein.png" width=170 align="right" />

| branch        | master | dev  |
| ------------- | ------ | ---- |
| R CMD check   | [![master-branch](https://github.com/STATWORX/helfRlein/actions/workflows/r-cmd-check-fix.yml/badge.svg?branch=dev)](https://github.com/STATWORX/helfRlein/actions/workflows/r-cmd-check-fix.yml) | [![dev-branch](https://github.com/STATWORX/helfRlein/actions/workflows/dev-check.yml/badge.svg?branch=dev)](https://github.com/STATWORX/helfRlein/actions/workflows/dev-check.yml) |
| test coverage | [![master-test-coverage](https://img.shields.io/codecov/c/github/STATWORX/helfRlein/master.svg)](https://codecov.io/gh/STATWORX/helfRlein/branch/master) | [![dev-test-coverage](https://img.shields.io/codecov/c/github/STATWORX/helfRlein/dev.svg)](https://codecov.io/gh/STATWORX/helfRlein/branch/dev) |
| lints         | [![master-lints](https://github.com/STATWORX/helfRlein/workflows/lints/badge.svg?branch=master)](https://github.com/STATWORX/helfRlein/actions?query=workflow%3Alints+branch%3Amaster) | [![dev-lints](https://github.com/STATWORX/helfRlein/workflows/lints/badge.svg?branch=dev)](https://github.com/STATWORX/helfRlein/actions?query=workflow%3Alints+branch%3Adev) |

----

## Overview

This package contains a collection of R helper functions. There are two main topics:

- general helper functions that ease our programing life
- functions that ease our daily work and projects

With version 1.0.0. stand alone functions like [burglr](https://www.statworx.com/de/blog/burglr-stealing-code-from-the-web/) and [dive](http://www.statworx.com/de/blog/dive-the-debugging-function-you-deserve/) have been removed. See the [NEWS](NEWS.md) for more details.


## Installation

``` r
# install.packages("devtools")
devtools::install_github("STATWORX/helfRlein")

# installing the dev version
devtools::install_github("STATWORX/helfRlein", ref = "dev")

```



## List of functions


### general helper functions

- `char_replace()`
  A function that replaces special characters within strings.
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
- `save_rds_archive()`
  Archives existing identically named `.RDS` files (with a time stamp) instead of silently overwriting them.
- `statusbar()`
  A progress bar for for-loops.
- `strsplit()`
  This functions adds the possibility to keep the delimiter after, before or between a given split.
- `to_na()`
  Takes out `NaN` and `Inf` values and replaces them with `NA`.
- `trim()`
  Removes leading and / or trailing whitespaces.

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
- `set_new_chapter()`
  An addin to insert dashes from the courser position up to 80 characters.
- `statworx_palette()`
  This functions creates a colour palette based on our CI colours.

