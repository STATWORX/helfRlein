.onAttach <- function(libname, pkgname) {
  #setHook(packageEvent("helfRlein", "attach", function(...) {
    packageStartupMessage(
      "----------------------------------\n",
      "Function statusbar and read_files have deprecated arguments. ",
      "For more details see help files.\n",
      "----------------------------------")
   # }))
}
