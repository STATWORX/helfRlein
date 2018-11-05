# helfRlein <img src="img/helfRlein.png" width=170 align="right" />
[![CircleCI](https://circleci.com/gh/STATWORX/helfRlein.svg?style=svg)](https://circleci.com/gh/STATWORX/helfRlein)
----

## Overview

This package contains a collection of R helper functions. Some are independed and already described at our blog (eg. [burglr](https://www.statworx.com/de/blog/burglr-stealing-code-from-the-web/) or [dive](http://www.statworx.com/de/blog/dive-the-debugging-function-you-deserve/)). Others are part of our daily work.


## Installation

``` r
# install.packages("devtools")
devtools::install_github("STATWORX/helfRlein")
```

## Usage

To insure an always stable and running package the `master` branch should only be used for version updates and the developement is done on the `dev` branch.
If you run into a problem, maybe there is a solution in the wiki. If not, just let us know and add an issue.



## List of functions

- `burglr()` 
  A functions to source code from the web. You can find a detailed introduction to this function [here](https://www.statworx.com/de/blog/burglr-stealing-code-from-the-web/).
- `checkdir()`
  Combines `file.exists()` and `dir.create()`.
- `clean_gc()` 
  A function that calls `gc()` numerous times.
- `dive()`
  A debugging function for that will sort out the parameters for you. You can use it for example with Sublime. You can find a detailed introduction to this function [here](https://www.statworx.com/de/blog/dive-the-debugging-function-you-deserve/).
- `get_files()`
  A functions for finding patterns in R Files.
- `get_network()` 
  A function that visualises the connections between UDF within your project. You can find a detailed introduction to this function [here](https://github.com/STATWORX/blog/tree/master/flowchart).
- `get_sequence()`
  A function that returns start and end indices of sequences of a number pattern.
- `intersect2()`
  This function returns the intersect between multiple vectors.
- `multiplot()`
  A function to combine different ggplots into one plot.
- `na_omitlist()`
  A function to remove missing values from a list.
- `print_fs()`
  This function prints the folder and file structure of a given path.
- `sci_palette()`
  A functions that shows STATWORX's CI colours. 
- `statworx_palette()`
  This functions creates a colour palette based on our CI colours.
- `strsplit()`
  This functions uses adds the possibility to keep the delimiter after, before or between a given split.
- `to_na()`
  Takes out `NaN` and `Inf` values and replaces them with `NA`.



