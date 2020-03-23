#' @title flowchart of R projects
#' 
#' @description
#' With this function a network plot of the connections of the functions
#' in a given path can be created.
#'
#' @param dir a path that includes the functions 
#' @param variations a character vector with the function's definition string.
#'   The default is c(" <- function", "<- function", "<-function").
#' @param pattern a string with the file suffix - default is "\\.R$".
#' @param simplify a boolean, if \code{TRUE} function with no connections are
#'   removed from the plot.
#' @param all_scripts a named list with script. The given path is dominant. This
#'   is mainly used for debugging purposes.
#' @param use_internals a boolean, if \code{FALSE} than only functions
#'   that are also a file's name are used. This should respond to internal
#'   functions. The default is \code{TRUE}.
#' @param exclude a vector with folder's or function's names, that are excluded
#'   from the network creation. This is done by a regex, so it will remove
#'   everything that contains these words.
#'
#' @return
#'   Returns an object with the adjacency matrix \code{$matrix} and 
#'   and igraph object \code{$igraph}. 
#'   
#' @seealso For more information check out 
#' \href{https://www.statworx.com/de/blog/flowcharts-of-functions/}{our blog}.
#' Also there is a README on how to use this function 
#'  \href{https://github.com/STATWORX/blog/tree/master/flowchart}{here}.
#'  
#' @export
#' @author Jakob Gepp
#' 
#' @note
#' TODO: list with exclude files and comments ' ' in one line
#' 
#' TODO: maybe return plot
#' 
#' @examples 
#' \dontrun{
#' net <- get_network(dir = "R/", simplify = TRUE)
#' g1 <- net$igraph
#' plot(g1)
#' }
#' 

get_network <- function(dir = NULL,
                        variations = c("<- function",
                                       " <- function",
                                       "<-function",
                                       " <-function"),
                        pattern = "\\.R$",
                        simplify = FALSE,
                        all_scripts = NULL,
                        use_internals = TRUE,
                        exclude = NULL) {
  
  # check if dir exists
  if (!is.null(dir) && !dir.exists(dir)) {
    stop(paste0(dir, " does not exists"))
  }
  
  if (is.null(all_scripts)) {
    # get files and folder within dir
    files.path <- list.files(file.path(dir),
                             pattern = pattern,
                             recursive = TRUE,
                             full.names = TRUE)
    
    
    # removing files with exlude input
    if (!is.null(exclude)) {
      keep <- !grepl(pattern = paste0("(",
                                      paste0(exclude, collapse = ")|("),
                                      ")"),
                     x = files.path)
      files.path <- files.path[keep]
    }
    
    if (length(files.path) == 0) {
      stop("no files with the given pattern")
    }
    
    folder <- dirname(gsub(paste0(dir, "/"), "", files.path))
    
    # get all scripts
    all_scripts <- lapply(files.path, readLines, warn = FALSE)
    
    # set names of scripts
    names(all_scripts) <- gsub(pattern, "", basename(files.path))
    
  } else {
    # case were a list of scripts and functions is given
    # check names if 
    if (is.null(names(all_scripts))) {
      stop("given scripts needs to have names to indicate folders")
    }
    folder <- rep(".", length(all_scripts))
  }
  
  # check for emtpy scripts
  indx <- sapply(all_scripts, length) == 0
  if (any(indx)) {
    warning(paste0("removing empty scritps: ",
                   paste0(names(all_scripts)[indx], collapse = ", ")))
    all_scripts <- all_scripts[!indx]
    folder <- folder[!indx]
  }
  
  # remove variations with "
  # this is done so that strings like "<- function" will not be counted
  for (i.var in variations) {
    # i.var <- variations[1]
    all_scripts <- lapply(all_scripts,
                          function(x) gsub(paste0("\"", i.var ), "", x))
  }
  
  # remove method / functions that start with [
  # otherwise the regex will be messed up later
  keep <- !startsWith(names(all_scripts), "[")
  all_scripts <- all_scripts[keep]
  folder <- folder[keep]
  
  
  # unique(unlist(sapply(variations, grep, all_scripts)))
  
  # remove leading spaces
  all_scripts <- lapply(all_scripts, function (x)  sub("^\\s+", "", x))
  
  # split before #
  all_scripts <- 
    lapply(all_scripts,
           function(x) unlist(strsplit(x = x, split = "#", type = "before")))
  # remove comments #
  all_scripts <- lapply(all_scripts, function(x) subset(x, !startsWith(x, "#")))
  
  # comment blocks with `` will still be counted
  # NEEDS MORE THINKING # remove comment block by ''
  # NEEDS MORE THINKING comment_index <- lapply(all_scripts, 
  # NEEDS MORE THINKING   function(x) {
  # NEEDS MORE THINKING     startsWith(x, "'")
  # NEEDS MORE THINKING     endsWith(x, "'")
  # NEEDS MORE THINKING     #ind <- which(grepl("'", x))
  # NEEDS MORE THINKING     #rep_ind <- (str_count(x[ind], "'") %% 2) + 1
  # NEEDS MORE THINKING     #matrix(rep(ind, rep_ind), ncol = 2, byrow = TRUE)
  # NEEDS MORE THINKING   }
  # NEEDS MORE THINKING )
  
  # NEEDS MORE THINKING comment_index <- lapply(comment_index,
  # NEEDS MORE THINKING                         function(y) apply(y, 1, function(x) seq(x[1], x[2], 1)))
  
  # NEEDS MORE THINKING comment_index <- lapply(comment_index, unlist)
  
  # NEEDS MORE THINKING all_scripts <- mapply(function(x, y) subset(x, !seq_along(x) %in% y),
  # NEEDS MORE THINKING                       all_scripts, comment_index)
  
  # split before { and }
  all_scripts <- 
    lapply(all_scripts,
    function(x) unlist(strsplit(x = x, split = "[\\{\\}]", type = "before")))
  
  # split after { and }
  all_scripts <- 
    lapply(all_scripts,
    function(x) unlist(strsplit(x = x, split = "[\\{\\}]", type = "after")))
  
  
  # remove empty lines
  all_scripts <- lapply(all_scripts, function(x) x[x != ""])
  
  # filter only those with functions (variations) in it
  index_functions <- unique(unlist(sapply(variations, grep, all_scripts)))
  main.functions  <- all_scripts[index_functions]
  folder.main     <- folder[index_functions]
  scripts         <- all_scripts[-index_functions]
  folder.scripts  <- folder[-index_functions]
  
  # adjust name with first definition - removed
  #main_names <- sapply(main.functions,
  #  function(x) x[sort(unique(unlist(sapply(variations, grep, x))))][1])
  #names(main.functions) <- gsub(" ", "", sapply(base::strsplit(main_names, "<-"), "[[", 1))
  
  # remove " <- functions" within strings in functions
  #all.functions <- lapply(all.functions,
  #                        function (x)  sub("\" <- function", "", x))
  
  # get subfunctions
  getsubindex <- function(funlist,
                          variations) {
    def.function.index <- 
      lapply(funlist,
             function(x) sort(unique(unlist(
               lapply(variations,
                      function(y) which(grepl(pattern = y, x))))
             ))
      )
    
    # get internal functions
    with_internal <- which(sapply(def.function.index, length) > 1)
    internal <- funlist[with_internal]
    def_internal <- lapply(def.function.index[with_internal], function(x) sort(x))
    
    open  <- lapply(internal, function(x) as.numeric(grepl("\\{", x)))
    close <- lapply(internal, function(x) as.numeric(grepl("\\}", x)))
    both <- mapply(function(x,y) cumsum(x - y), open, close, SIMPLIFY = FALSE)
    
    sub_index_end <- mapply(function(x, z)
      sapply(z, function(y) {
        tmp <- which(x == x[y])
        tmp <- tmp[tmp > y]
        if (length(tmp) == 1) {
          tmp
        } else {
          if (all(diff(tmp) == 1)) {
            suppressWarnings(min(tmp, na.rm = TRUE) - 1)
          } else {
            suppressWarnings(min(tmp[c(diff(c(y, tmp)) > 1)], na.rm = TRUE) - 1)
          }
        }
      }),
      both, def_internal, SIMPLIFY = FALSE)
    
    # set Inf to max length
    max_length <- lapply(internal, length)
    sub_index_end <- mapply(function(x, y)
      ifelse(x == Inf, y, x),
      sub_index_end, max_length, SIMPLIFY = FALSE)
    
    sub_index <- mapply(function(x, y) cbind(x, y),
                        def_internal, sub_index_end, SIMPLIFY = FALSE)
    
    # remove row if it is from first to last
    sub_index <- mapply(
      function(x, y) matrix(x[!apply(x, 1, diff) >= c(y - 2),], ncol = 2),
      sub_index, max_length, SIMPLIFY = FALSE)
    
    out <- list()
    out$sub_index <- sub_index
    out$internal <- internal
    
    return(out)
  }
  
  tmp <- getsubindex(funlist = main.functions,
                     variations = variations)
  sub_index <- tmp$sub_index
  internal  <- tmp$internal
  
  sub_functions <- 
    mapply(function(i, s) lapply(1:nrow(s), function(t) i[s[t, 1]:s[t, 2]]),
           internal, sub_index, SIMPLIFY = FALSE)
  sub_functions <- do.call("c", sub_functions)
  
  # folder for sub_functions
  folder.index <- which(names(sub_index) %in% names(main.functions))
  folder.sub <- rep(folder.main[folder.index], sapply(sub_index, nrow))
  
  def.sub_functions <- 
    unlist(lapply(seq_along(sub_functions),
                  function(x) sub_functions[[x]][1]))
  #def.sub_function.index[[x]]
  
  if (!is.null(def.sub_functions)) {
    names(sub_functions) <- 
      unlist(gsub(" ", "", lapply(base::strsplit(def.sub_functions, "<-"), "[[", 1))) 
  }
  
  
  # combine sub to all functions
  if (use_internals) {
    all.functions <- c(main.functions, sub_functions)
    all.folder    <- c(folder.main, folder.sub)
  } else {
    all.functions <- main.functions
    all.folder    <- folder.main
  }
  
  
  # remove duplicates
  index <- !duplicated(all.functions)
  all.functions <- all.functions[index]
  all.folder    <-  all.folder[index]
  
  dup_names <- duplicated(names(all.functions))
  if (any(dup_names)) {
    warning(paste0("multiple function: ",
                   paste0(unique(names(all.functions)[dup_names]),
                          collapse = ", "),
                   " Using only the first!"))
    all.functions <- all.functions[!dup_names]
    all.folder    <- all.folder[!dup_names]
  }
  
  # remove sub_functions from functions
  tmp <- getsubindex(funlist = all.functions,
                     variations = variations)
  
  for (i.name in names(tmp$sub_index)) {
    # i.name <- names(tmp$sub_index)[1]
    #print(i.name)
    i.num <- which(names(all.functions) == i.name)
    s <- tmp$sub_index[[i.name]]
    if (nrow(s) == 0) next
    remove.index <- unique(unlist(sapply(1:nrow(s),
                                         function(t) s[t, 1]:s[t, 2])))
    all.functions[[i.num]][remove.index] <- ""
  }
  
  # remove empty lines
  all.functions <- lapply(all.functions, function(x) x[x != ""])
  
  # combine sub to all functions
  all.files  <- c(all.functions, scripts)
  all.folder <- c(all.folder, folder.scripts)
  
  # check if there are functions
  if (length(all.files) == 0) {
    warning("no functions found")
    return(list(matrix = NULL, igraph = NULL))
  }
  
  # get number of line per function
  lines <- sapply(all.files, length)
  
  # update function definition
  def.function.index <- 
    lapply(all.files,
           function(x) unique(unlist(
             lapply(variations,
                    function(y) which(grepl(pattern = y, x))))
           )
    )
  
  def.functions <- 
    unlist(lapply(seq_along(all.files),
                  function(x) all.files[[x]][def.function.index[[x]]]))

  def.functions <- 
    unique(unlist(gsub(" ", "",
                       lapply(base::strsplit(def.functions, "<-"), "[[", 1))))
  
  # used for later adjustments of the network matrix
  def.functions2 <- 
    lapply(seq_along(all.files),
           function(x) all.files[[x]][def.function.index[[x]]])
  
  # check for non characters
  def.functions2 <- 
    lapply(def.functions2, function(x) {
      if (is.character(x)) {
        x
      } else {
        character(0)
      }
    }) 
  
  
  def.functions2 <- 
    lapply(def.functions2,
           function(x) gsub(" ", "", sapply(base::strsplit(x, "<-"), "[[", 1)))
  
  def.functions2 <- 
    lapply(seq_along(def.functions2),
           function(x) ifelse(length(def.functions2[[x]]) == 0,
                              names(all.files)[x],
                              def.functions2[[x]])
    )
  
  # remove function definition
  keep_lines <- mapply(function(x, y) which(!1:y %in% x),
                       def.function.index, lapply(all.files, length),
                       SIMPLIFY = FALSE)
  
  
  clean.functions <- all.files
  clean.functions <- 
    lapply(seq_along(clean.functions),
           function(x) clean.functions[[x]][keep_lines[[x]]])
  names(clean.functions) <- names(all.files)
  
  # remove duplicated names
  dub_rows <- !duplicated(names(clean.functions))
  if (!all(dub_rows)) {
    warning(paste0("removing duplicates: ",
                   paste0(names(clean.functions)[!dub_rows], collapse = ", ")))
    clean.functions <- clean.functions[dub_rows]
    lines <- lines[dub_rows]
    all.folder <- all.folder[dub_rows]
    def.functions2 <- def.functions2[dub_rows]
  }
  
  # create adjacency matrix: network
  network <-
    lapply(clean.functions,
           function(z) {
             # z <- clean.functions[[1]]
             sapply(paste0(def.functions), #, "\\("
                    function(x, y = z) sum(grepl(x, y), na.rm = TRUE))
           })
  
  network <- as.data.frame(do.call(rbind, network))
  
  # adjust networks rows and columns
  names(network) <- gsub("\\\\\\(", "", names(network))
  new_collumns <- rownames(network)[which(!rownames(network) %in% colnames(network))]
  new_rows <- colnames(network)[which(!colnames(network) %in% rownames(network))]
  network[, new_collumns] <- 0
  network[new_rows, ] <- 0
  network <- network[rownames(network)]
  
  # adjust lines, folders
  old_names <- names(lines)
  lines <- c(lines, rep(0, length(new_rows)))
  names(lines) <- c(old_names, new_rows)
  
  tmp.index <- sapply(new_rows,
                      function(y) which(lapply(def.functions2,
                                               function(x) x == y) == TRUE))
  if (length(tmp.index) == 0) {
    tmp.index <- NULL
  }
  
  all.folder <- c(all.folder, all.folder[tmp.index])
  
  # simplify - removing functions with no connections
  if (simplify) {
    calls <- apply(1, X = network, FUN = sum) + apply(2, X = network, FUN = sum)
    keep <- which(calls != 0)
    network <- network[keep, keep]
    all.folder <- all.folder[keep]
    lines <- lines[keep]
  }
  
  # create igraph
  g1 <- igraph::graph_from_adjacency_matrix(
    as.matrix(network),
    mode = c("directed"),
    weighted = TRUE,
    diag = TRUE,
    add.colnames = NULL,
    add.rownames = NA)
  
  igraph::V(g1)$label  <- names(lines)
  igraph::V(g1)$size   <- 10*lines/max(lines)
  igraph::V(g1)$folder <- all.folder
  igraph::V(g1)$color  <- as.numeric(as.factor(all.folder))
  
  # output
  out <- list()
  out$matrix <- network
  out$igraph <- g1
  
  return(out)
}



