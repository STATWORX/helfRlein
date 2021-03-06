% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/print_fs.R
\name{print_fs}
\alias{print_fs}
\title{Print file structure}
\usage{
print_fs(
  path = ".",
  depth = 2L,
  print = TRUE,
  return = FALSE,
  prefix = "",
  level = 0
)
}
\arguments{
\item{path}{a folder path.}

\item{depth}{a positive integer with the depth of the folder structure.}

\item{print}{a boolean if TRUE (default), the file structure will be printed}

\item{return}{a boolean if TRUE, the file structure is returned as a vector.
If FALSE the return is NULL. The default value is FALSE.}

\item{prefix}{internal character to indicate the indention of depth.}

\item{level}{internal numeric to indicate the current depth.}
}
\value{
Either the file structure or NULL
}
\description{
Prints the directories and files of the given path.
}
\examples{

print_fs(path = ".")

}
\author{
Jakob Gepp
}
