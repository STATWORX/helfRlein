# script to create the DESCRIPTION file

# get news class
# devtools::install_github("Dschaykib/newsmd")
# install.packages("desc")
library(newsmd)

# update roxygen
roxygen2::roxygenise()

# Remove default DESC and NEWS.md
unlink("DESCRIPTION")
unlink("NEWS.md")


# initial files -----------------------------------------------------------

# Create a new description object
my_desc <- desc::description$new("!new")
my_news <- newsmd()

# Set your package name
my_desc$set("Package", "helfRlein")
# Set license
my_desc$set("License", "MIT + file LICENSE")

# Remove some author fields
my_desc$del("Maintainer")
# Set the version
my_desc$set_version("0.0.0.9000")
# The title of your package
my_desc$set(Title = "R-Helper functions")
# The description of your package
my_desc$set(Description = "A usefull collection of R helper functions.")
# The urls
my_desc$set("URL", "https://github.com/STATWORX/helfRlein")
my_desc$set("BugReports",
            "https://github.com/STATWORX/helfRlein/issues")

#Set authors
my_desc$set("Authors@R", "person('Jakob', 'Gepp', email = 'jakob.gepp@statworx.com', role = c('cre', 'aut'))")
my_desc$add_author('Daniel', 'Luettgau',
                   email = 'daniel.luettgau@statworx.com',
                   role = c('aut'))


# set R version
my_desc$set_dep("R", type = desc::dep_types[2], version = ">= 3.3.3")

# set suggests
my_desc$set_dep("testthat", type = desc::dep_types[3], version = "*")

# set dependencies
my_desc$set_dep("data.table", type = desc::dep_types[1], version = ">= 1.9")



# initial functions -------------------------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())

my_news$add_subtitle("initial functions")
my_news$add_bullet(c("clean_gc.R",  "intersect2.R", "multiplot.R",
                     "na_omitlist.R", "strsplit.R", "to_na.R"))


# adding more functions and authors ---------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())
my_desc$set_dep("igraph", type = desc::dep_types[1], version = ">= 1.1.2")
my_desc$set_dep("data.tree", type = desc::dep_types[1], version = ">= 0.7.0")
my_desc$set_dep("stringr", type = desc::dep_types[1], version = ">= 1.2.0")
my_desc$set_dep("RCurl", type = desc::dep_types[1], version = "*")

my_desc$add_author('Andre', 'Bleier',
                   email = 'andre.bleier@statworx.com',
                   role = c('aut'))
my_desc$add_author('Markus', 'Berroth',
                   email = 'markus.berroth@statworx.com',
                   role = c('ctb'))

my_news$add_subtitle("added functions")
my_news$add_bullet(c("burglr.R", "dive.R", "get_network.R",
                     "get_sequence.R", "print_fs.R"))


# first stable version 0.1 ------------------------------------------------

my_desc$bump_version("minor")
my_news$add_version(my_desc$get_version())

my_news$add_bullet("made available for first testing")

# adding more functions and authors
my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())
my_desc$set_dep("readr", type = desc::dep_types[1], version = ">= 1.1.1")
my_desc$set_dep("magrittr", type = desc::dep_types[1], version = ">= 1.1.1")
my_desc$set_dep("grDevices", type = desc::dep_types[1], version = "*")
my_desc$set_dep("graphics", type = desc::dep_types[1], version = "*")


my_desc$add_author('Tobias', 'Krabel',
                   email = 'tobias.krabel@statworx.com',
                   role = c('aut'))
my_desc$add_author('Martin', 'Albers',
                   email = 'martin.albers@statworx.com',
                   role = c('aut'))

my_news$add_subtitle("added functions")
my_news$add_bullet(c("get_files", "sci_palette.R"))

my_news$add_subtitle("setup")
my_news$add_bullet(c("changed folder structure within git",
                     "updated `.gitignore`"))


# restructure git ---------------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())

my_desc$set_dep("R6", type = desc::dep_types[3], version = "*")

my_news$add_bullet(c("restructure folder structure within the git",
                     "added tests for functions"))



# automated NEWS and DESCRIPTION ------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())

my_news$add_bullet(c("added automated creation for DESCRIPTION and NEWS.md",
                     "added tests for functions"))


# bug fix plot.sci --------------------------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())

my_desc$set_dep("newsmd", type = desc::dep_types[3], version = "*")
my_desc$del_dep("R6")

my_news$add_subtitle("Bugfixes")
my_news$add_bullet(c("fix plot.sci into own method script",
                     "added cirlceCI"))



# add functionality to strsplit --------------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("added functionality")
my_news$add_bullet(c("strstplit can now split between two delimiters"))


# add statworx_palette ----------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("added functions")
my_news$add_bullet(c("statworx_palette uses sci_palette to create a color palette"))


# update get_network ------------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("added functionality")
my_news$add_bullet(c("added tests and documentation for get_network"))



# add checkdir and minor fixes --------------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("added functions")
my_news$add_bullet(c("checkdir - checks and creates a folder",
                     "update get_sequence for longer pattern"))
my_news$add_subtitle("Bugfixes")
my_news$add_bullet(c("fix typos",
                     "adjust tests"))

my_desc$add_author('Robin', 'Kraft',
                   email = 'robin.kraft@statworx.com',
                   role = c('ctb'))


# add functions to fil up to 24 -------------------------------------------

my_desc$bump_version("minor")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("added functions")
my_news$add_bullet(c(
  "statusbar - progress bar for for loops",
  "evenstrings - split string to given max length",
  "trim - remove leading and / or trailing whitespaces",
  "count_na - counts NAs wihtin a variable",
  "read_files - reads multiple files into one data.table",
  "%nin% - 'not in' operator",
  "object_size_in_env - shows objects ordered by their size",
  "char_replace - replaces non-standard characters with their standard equivalents"))

my_news$add_subtitle("Bugfixes")
my_news$add_bullet(c("fix empty scripts get_network()",
                     "adjust intersect2 for lists"))


my_desc$add_author('David', 'Schlepps',
                   email = 'david.schlepps@statworx.com',
                   role = c('ctb'))
my_desc$add_author('Oliver', 'Guggenbuehl',
                   email = 'oliver.guggenbuehl@statworx.com',
                   role = c('ctb'))

# update paletten __------------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("update function")
my_news$add_bullet(c("changed color names and added a red color to the palette",
                     "removed 'number' form sci_palette()"))

# minor changes -----------------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("Bugfixes")
my_news$add_bullet(c("rename prop to mean in count_na"))

# minor changes -----------------------------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("Bugfixes")
my_news$add_bullet(c("moved trim before underscore replacement"))

# minor changes -----------------------------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("added functionality")
my_news$add_bullet(c("char_replace changes ALT+SPACE to a normal SPACE"))

# fix statusbar -----------------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("Bugfixes")
my_news$add_bullet(c("statusbar now can handle character max.run with length one"))

# fix statusbar -----------------------------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("Bugfixes")
my_news$add_bullet(c("object_size_in_env is now exported",
                     "added test for exporting functions"))


# adding new function and testall -----------------------------------------

my_desc$bump_version("minor")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("update function")
my_news$add_bullet(c("get_network has now a exclude list and can ignore internal functions"))



# testing R 4.0.0 ---------------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("internal changes")
my_news$add_bullet(c("adjusting tests for R 4.0.0",
                     "cleaning code"))
my_news$add_subtitle("Bugfixes")
my_news$add_bullet(c("removing ASCII characters"))


# refactoring package -----------------------------------------------------

my_desc$bump_version("major")
my_news$add_version(my_desc$get_version())
my_news$add_subtitle("update function")
my_news$add_bullet(c("removing dive and burglr"))

my_news$add_subtitle("internal changes")
my_news$add_bullet(c("including github actions",
                     "removing other CI"))
my_news$add_subtitle("styling")
my_news$add_bullet(c("fixing lints"))

# save everything ---------------------------------------------------------

my_desc$set("Date", Sys.Date())
my_desc$write(file = "DESCRIPTION")
my_news$write(file = "NEWS.md")


