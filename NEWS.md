## version 1.5.0

---


### Feature

- get_network now also creates an interactive plot


### Bugfixes

- added error handling wihtin get_network


## version 1.4.2

---


### Bugfixes

- fix error in get_network with duplicated inner functions names


## version 1.4.1

---


### Bugfixes

- get_network can now handle files with only comments
- fix get_network internal list handling


## version 1.4.0

---


### Bugfixes

- fix warning in statusbar


### update function

- Add uniqueness to read_files


## version 1.3.0

---


### Bugfixes

- fix naming and order for statworx pallete
- fix default value for read_files to avoid 'close to the limit' error


## version 1.2.0

---


### update function

- Add new STATWORX colour scheme to sci_palette and statworx_pallete


## version 1.1.4

---


### Bugfixes

- add line break after last step in statusbar


## version 1.1.3

---


### internal changes

- add renv structure
- change test setup, more detail can be found [here](.github/README.md)
- include remotes, rcmdcheck, desc and lintr to 'Suggests'


## version 1.1.2

---


### Bugfixes

- fixed plugin for coment line setting
- fixed FUN argument error in read_files


## version 1.1.1

---


### Bugfixes

- changing error messages


### dependencies

- adding utils
- adding grid
- removing readr
- removing magrittr


### internal test setup changes

- changing test setup to fix and relative R versions
- setting Ubuntu test setup to 16.04 instead of latest


## version 1.1.0

---


### removing dependencies

- data.tree
- restructering print_fs


### Bugfixes

- adding lint exceptions


## version 1.0.2

---


### Bugfixes

- fixing backwards compability


## version 1.0.1

---


### internal test setup changes

- removing ubuntu with R version 4.0 in the test setup
- changing lintr options


## version 1.0.0

---


### removing dependencies

- RCurl, stringr


### styling

- fixing lints


### internal changes

- including GitHub Actions
- removing other CI services
- adjusting tests for Windows
- adjusting needed R version


### update function

- removing dive and burglr
- adding new function 'save_rds_archive'
- adding shoRtcut (set_new_chapter()) addin
- read_files now as 'fun' instead of 'FUN' parameter


## version 0.3.1

---


### Bugfixes

- removing ASCII characters


### internal changes

- adjusting tests for R 4.0.0
- cleaning code


## version 0.3.0

---


### update function

- get_network has now a exclude list and can ignore internal functions


## version 0.2.3.9000

---


### Bugfixes

- object_size_in_env is now exported
- added test for exporting functions


## version 0.2.3

---


### Bugfixes

- statusbar now can handle character max.run with length one


## version 0.2.2.9001

---


### added functionality

- char_replace changes ALT+SPACE to a normal SPACE


## version 0.2.2.9000

---


### Bugfixes

- moved trim before underscore replacement


## version 0.2.2

---


### Bugfixes

- rename prop to mean in count_na


## version 0.2.1

---


### update function

- changed color names and added a red color to the palette
- removed 'number' form sci_palette()


## version 0.2.0

---


### Bugfixes

- fix empty scripts get_network()
- adjust intersect2 for lists


### added functions

- statusbar - progress bar for for loops
- evenstrings - split string to given max length
- trim - remove leading and / or trailing whitespaces
- count_na - counts NAs wihtin a variable
- read_files - reads multiple files into one data.table
- %nin% - 'not in' operator
- object_size_in_env - shows objects ordered by their size
- char_replace - replaces non-standard characters with their standard equivalents


## version 0.1.4.9000

---


### Bugfixes

- fix typos
- adjust tests


### added functions

- checkdir - checks and creates a folder
- update get_sequence for longer pattern


## version 0.1.4

---


### added functionality

- added tests and documentation for get_network


## version 0.1.3

---


### added functions

- statworx_palette uses sci_palette to create a color palette


## version 0.1.2.9001

---


### added functionality

- strstplit can now split between two delimiters


## version 0.1.2.9000

---


### Bugfixes

- fix plot.sci into own method script
- added cirlceCI


## version 0.1.2

---

- added automated creation for DESCRIPTION and NEWS.md
- added tests for functions

## version 0.1.1

---

- restructure folder structure within the git
- added tests for functions

## version 0.1.0.9000

---


### setup

- changed folder structure within git
- updated `.gitignore`


### added functions

- get_files
- sci_palette.R


## version 0.1.0

---

- made available for first testing

## version 0.0.0.9002

---


### added functions

- burglr.R
- dive.R
- get_network.R
- get_sequence.R
- print_fs.R


## version 0.0.0.9001

---


### initial functions

- clean_gc.R
- intersect2.R
- multiplot.R
- na_omitlist.R
- strsplit.R
- to_na.R


## version 0.0.0.9000

---

### NEWS.md setup

- added NEWS.md creation with newsmd

