
# DONE filter for internal functions and put them in an extra list
# DONE add scripts
# DONE maybe replace { } into sepereate lines
# DONE folder structure
# TODO list with exclude files
# TODO '' in one line

#' @title flowchart of R projects
#'
#' @param dir a path that includes the functions 
#' @param variations a charachter vector with the functions definition string.
#'   The default is c(" <- function", "<- function", "<-function").
#' @param pattern a string with the file suffix - default is "\\.R".
#'
#' @return
#'   Returns an object with the adjacency matrix \code{$matrix} and 
#'   and igraph object \code{$igraph}. 
#' @export
#'
#' @examples
#' 
getnetwork <- function(dir,
                       variations = c(" <- function", "<- function", "<-function"),
                       pattern = "\\.R") {
  # dir <- "~/Projekte/Lufthansa/Pele_git/PELE2/PELE/source/Agam_aggregation"
  # rm(list = ls())
  # recursive = TRUE
  # variations = c(" <- function", "<- function", "<-function")
  # pattern = "\\.R"
  # dir <- "/Users/jakobgepp/Projekte/2018/Intern/R Network functions"
  # dir <- "/Users/jakobgepp/Projekte/Lufthansa/Server-tmp/for_andre/PELE_AB/source/Boosting"
  
  # get files
  files.path <- list.files(dir,
                           pattern = pattern,
                           recursive = TRUE,
                           full.names = TRUE)
  
  folder <- dirname(gsub(paste0(dir, "/"), "", files.path))
  
  # get all scripts
  all.scripts <- lapply(files.path, readLines, warn = FALSE)
  
  names(all.scripts) <- gsub(pattern, "", basename(files.path))
  
  # remove method / functions that start with [
  keep <- !startsWith(names(all.scripts), "[")
  all.scripts <- all.scripts[keep]
  folder <- folder[keep]
  
  # leading spaces
  all.scripts <- lapply(all.scripts,
                        function (x)  sub("^\\s+", "", x))
  # remove comments #
  all.scripts <- lapply(all.scripts,
                        function(x) subset(x, !startsWith(x, "#")))
  
  # NEEDS MORE THINKING # remove comment block by ''
  # NEEDS MORE THINKING comment_index <- lapply(all.scripts, 
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
  
  # NEEDS MORE THINKING all.scripts <- mapply(function(x, y) subset(x, !seq_along(x) %in% y),
  # NEEDS MORE THINKING                       all.scripts, comment_index)
  
  # split before {
  all.scripts <- lapply(all.scripts,
    function(y) {
      unlist(lapply(y,
        function(x) { 
          ind <- unlist(gregexpr(pattern = "\\{", x))
          ind_start <- unique(c(1,ind))
          ind_end   <- unique(c(ind_start[-1] - 1, nchar(x)))
          return(substring(x, ind_start, ind_end))
        })
      )
    }
  )
  
  # split before }
  all.scripts <- lapply(all.scripts,
    function(y) {
      unlist(lapply(y,
        function(x) { 
          ind <- unlist(gregexpr(pattern = "\\}", x))
          ind_start <- unique(c(1,ind))
          ind_end   <- unique(c(ind_start[-1] - 1, nchar(x)))
          return(substring(x, ind_start, ind_end))
        })
      )
    }
  )
  
  # remove empty lines
  all.scripts <- lapply(all.scripts, function(x) x[x != ""])
  
  # filter only those with functions (variations) in it
  index_functions <- unique(unlist(sapply(variations, grep, all.scripts)))
  main.functions  <- all.scripts[index_functions]
  folder.main     <- folder[index_functions]
  scripts         <- all.scripts[-index_functions]
  folder.scripts  <- folder[-index_functions]
  
  # adjust name with first definition - removed
  #main_names <- sapply(main.functions,
  #  function(x) x[sort(unique(unlist(sapply(variations, grep, x))))][1])
  #names(main.functions) <- gsub(" ", "", sapply(strsplit(main_names, "<-"), "[[", 1))

  # remove " <- functions" within strings in functions
  #all.functions <- lapply(all.functions,
  #                        function (x)  sub("\" <- function", "", x))
  
  # get subfunctions
  getsubindex <- function(funlist,
                          variations) {
    def.function.index <- 
      lapply(funlist,
             function(x) unique(unlist(lapply(variations,
                                              function(y) which(grepl(pattern = y, x))))
                                )
             )
    
    # get internal functions
    # TODO fix error with {}
    
    with_internal <- which(sapply(def.function.index, length) > 1)
    internal <- funlist[with_internal]
    def_internal <- lapply(def.function.index[with_internal], function(x) sort(x)) # [-1]
    
    open  <- lapply(internal, function(x) as.numeric(grepl("\\{", x)))
    close <- lapply(internal, function(x) as.numeric(grepl("\\}", x)))
    both <- mapply(function(x,y) cumsum(x - y), open, close, SIMPLIFY = FALSE)
    #both <- lapply(both, function(x) cumsum(abs(diff(c(0, x)))))

    # sub_index_end   <- mapply(function(x, y)
    #   sapply(y, function(y) min(which(x == x[y[1]])[(which(x == x[y[1]]) > y[1])]) - 1),
    #   both, def_internal, SIMPLIFY = FALSE)
    # 
        
    sub_index_end <- mapply(function(x, y)
      sapply(y, function(y) {
        tmp <- which(x == x[y[1]])
        min(tmp[tmp > y[1]][
          c(FALSE, diff(tmp[tmp > y[1]]) > 1)],
          na.rm = TRUE) - 1
      }),
      both, def_internal, SIMPLIFY = FALSE)

    # set Inf to max length
    max_length <- lapply(internal, length)
    sub_index_end <- mapply(function(x, y)
      ifelse(x == Inf, y, x),
      sub_index_end, max_length)
    
    sub_index <- mapply(function(x, y) cbind(x, y),
                        def_internal, sub_index_end, SIMPLIFY = FALSE)
    
    # remove row if it is from first to last
    sub_index <- mapply(
      function(x, y) matrix(x[!apply(x, 1, diff) >= c(y - 2),], ncol = 2),
      sub_index, max_length)
    
    #sub_index <- mapply(function(x, y) lapply(y, function(z) which(x == x[z])),
    #                    both, def_internal)
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
  
  # update sub_function definition
  # def.sub_function.index <- 
  #   lapply(sub_functions,
  #          function(x) unique(unlist(lapply(variations,
  #                                           function(y) which(grepl(pattern = y, x))))
  #          )
  #   )
  
  def.sub_functions <- 
    unlist(lapply(seq_along(sub_functions),
                  function(x) sub_functions[[x]][1]))
  #def.sub_function.index[[x]]
  
  if (!is.null(def.sub_functions)) {
    names(sub_functions) <- unlist(gsub(" ", "", lapply(strsplit(def.sub_functions, "<-"), "[[", 1))) 
  }
  
  
  # combine sub to all functions
  all.functions <- c(main.functions, sub_functions)
  all.folder    <- c(folder.main, folder.sub)
  
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
  
  # get number of line per function
  lines <- sapply(all.files, length)
  
  # update function definition
  def.function.index <- 
    lapply(all.files,
           function(x) unique(unlist(lapply(variations,
             function(y) which(grepl(pattern = y, x))))
           )
    )

  def.functions <- 
    unlist(lapply(seq_along(all.files),
                  function(x) all.files[[x]][def.function.index[[x]]]))
  
  def.functions <- 
    unique(unlist(gsub(" ", "",
                       lapply(strsplit(def.functions, "<-"), "[[", 1))))
  
  keep_lines <- mapply(function(x, y) which(!1:y %in% x),
                       def.function.index, lapply(all.files, length),
                       SIMPLIFY = FALSE)
  
  # remove function definition
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
  }
  
  # create adjacency matrix: network
  network <-
    lapply(clean.functions,
           function(z) {
             sapply(paste0(def.functions #, "\\("
                           ),
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
  
  # create igraph
  g1 <- graph_from_adjacency_matrix(
    as.matrix(network),
    mode = c("directed"),
    weighted = TRUE,
    diag = TRUE,
    add.colnames = NULL,
    add.rownames = NA)
  
  V(g1)$label <- names(lines)
  V(g1)$size <- 10*lines/max(lines)
  V(g1)$folder <- all.folder
  V(g1)$color <- as.numeric(as.factor(all.folder))

  # output
  out <- list()
  out$matrix <- network
  out$igraph <- g1
  
  return(out)
}