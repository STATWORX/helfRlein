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
    files_path <- list.files(file.path(dir),
                             pattern = pattern,
                             recursive = TRUE,
                             full.names = TRUE)


    # removing files with exlude input
    if (!is.null(exclude)) {
      keep <- !grepl(pattern = paste0("(",
                                      paste0(exclude, collapse = ")|("),
                                      ")"),
                     x = files_path)
      files_path <- files_path[keep]
    }

    if (length(files_path) == 0) {
      stop("no files with the given pattern")
    }

    folder <- dirname(gsub(paste0(dir, "/"), "", files_path))

    # get all scripts
    all_scripts <- lapply(files_path, readLines, warn = FALSE)

    # set names of scripts
    names(all_scripts) <- gsub(pattern, "", basename(files_path))

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
  for (i_var in variations) {
    all_scripts <- lapply(all_scripts,
                          function(x) gsub(paste0("\"", i_var), "", x))
  }

  # remove method / functions that start with [
  # otherwise the regex will be messed up later
  keep <- !startsWith(names(all_scripts), "[")
  all_scripts <- all_scripts[keep]
  folder <- folder[keep]


  # remove leading spaces
  all_scripts <- lapply(all_scripts, function(x)  sub("^\\s+", "", x))

  # split before #
  all_scripts <-
    lapply(all_scripts,
           function(x) unlist(strsplit(x = x, split = "#", type = "before")))
  # remove comments #
  all_scripts <- lapply(all_scripts, function(x) subset(x, !startsWith(x, "#")))


  # split before { and }
  all_scripts <-
    lapply(all_scripts,
           function(x) unlist(strsplit(x = x, split = "[\\{\\}]", type = "before")))

  # split after { and }
  all_scripts <-
    lapply(all_scripts,
           function(x) unlist(strsplit(x = x, split = "[\\{\\}]", type = "after")))

  # remove leading spaces again
  all_scripts <- lapply(all_scripts, function(x)  sub("^\\s+", "", x))

  # remove empty lines
  all_scripts <- lapply(all_scripts, function(x) x[x != ""])

  # filter only those with functions (variations) in it
  index_functions <- unique(unlist(sapply(variations, grep, all_scripts)))
  main_functions  <- all_scripts[index_functions]
  folder_main     <- folder[index_functions]
  scripts         <- all_scripts[-index_functions]
  folder_scripts  <- folder[-index_functions]


  # get subfunctions
  getsubindex <- function(funlist,
                          variations) {
    def_function_index <-
      lapply(funlist,
             function(x) {
               sort(unique(unlist(
                 lapply(variations,
                        function(y) which(grepl(pattern = y, x))))
               ))
             }
      )

    # get internal functions
    with_internal <- which(sapply(def_function_index, length) > 1)
    internal <- funlist[with_internal]
    def_internal <- lapply(def_function_index[with_internal],
                           function(x) sort(x))

    open  <- lapply(internal, function(x) as.numeric(grepl("\\{", x)))
    close <- lapply(internal, function(x) as.numeric(grepl("\\}", x)))
    both <- mapply(function(x, y) cumsum(x - y), open, close, SIMPLIFY = FALSE)

    sub_index_end <- mapply(function(x, z) {
      sapply(z, function(y) {
        tmp <- which(x == x[y])
        tmp <- tmp[tmp > y]
        if (length(tmp) == 1) {
          tmp
        } else {
          if (all(diff(tmp) == 1)) {
            suppressWarnings(min(tmp, na.rm = TRUE))
          } else {
            suppressWarnings(min(tmp[c(diff(c(y, tmp)) > 1)], na.rm = TRUE))
          }
        }
      })},
      both, def_internal, SIMPLIFY = FALSE)


    # set Inf to max length
    max_length <- lapply(internal, length)
    sub_index_end <- mapply(function(x, y) ifelse(x == Inf, y, x),
                            sub_index_end, max_length, SIMPLIFY = FALSE)

    sub_index <- mapply(function(x, y) cbind(x, y),
                        def_internal, sub_index_end, SIMPLIFY = FALSE)

    # remove row if it is from first to last
    sub_index <- mapply(
      function(x, y) matrix(x[!apply(x, 1, diff) >= c(y - 2), ], ncol = 2),
      sub_index, max_length, SIMPLIFY = FALSE)

    out <- list()
    out$sub_index <- sub_index
    out$internal <- internal

    return(out)
  }

  tmp <- getsubindex(funlist = main_functions,
                     variations = variations)
  sub_index <- tmp$sub_index
  internal  <- tmp$internal

  sub_functions <-
    mapply(function(i, s) {
      lapply(seq_len(nrow(s)), function(t) i[s[t, 1]:s[t, 2]])
    },
    internal, sub_index, SIMPLIFY = FALSE)
  sub_functions <- do.call("c", sub_functions)

  # folder for sub_functions
  folder_index <- which(names(sub_index) %in% names(main_functions))
  folder_sub <- rep(folder_main[folder_index], sapply(sub_index, nrow))

  def_sub_functions <-
    unlist(lapply(seq_along(sub_functions),
                  function(x) sub_functions[[x]][1]))


  if (!is.null(def_sub_functions)) {
    names(sub_functions) <-
      unlist(gsub(" ", "",
                  lapply(base::strsplit(def_sub_functions, "<-"), "[[", 1)))
  }


  # combine sub to all functions
  if (use_internals) {
    all_functions <- c(main_functions, sub_functions)
    all_folder    <- c(folder_main, folder_sub)
  } else {
    all_functions <- main_functions
    all_folder    <- folder_main
  }


  # remove duplicates
  index <- !duplicated(all_functions)
  all_functions <- all_functions[index]
  all_folder    <-  all_folder[index]

  dup_names <- duplicated(names(all_functions))
  if (any(dup_names)) {
    warning(paste0("multiple function: ",
                   paste0(unique(names(all_functions)[dup_names]),
                          collapse = ", "),
                   " Using only the first!"))
    all_functions <- all_functions[!dup_names]
    all_folder    <- all_folder[!dup_names]
  }

  # remove sub_functions from functions
  tmp <- getsubindex(funlist = all_functions,
                     variations = variations)

  for (i_name in names(tmp$sub_index)) {
    i_num <- which(names(all_functions) == i_name)
    s <- tmp$sub_index[[i_name]]
    if (nrow(s) == 0) next
    remove_index <- unique(unlist(sapply(seq_len(nrow(s)),
                                         function(t) s[t, 1]:s[t, 2])))
    all_functions[[i_num]][remove_index] <- ""
  }

  # remove empty lines
  all_functions <- lapply(all_functions, function(x) x[x != ""])

  # combine sub to all functions
  all_files  <- c(all_functions, scripts)
  all_folder <- c(all_folder, folder_scripts)

  # check if there are functions
  if (length(all_files) == 0) {
    warning("no functions found")
    return(list(matrix = NULL, igraph = NULL))
  }

  # get number of line per function
  lines <- sapply(all_files, length)

  # update function definition
  def_function_index <-
    lapply(
      all_files,
      function(x) {
        unique(unlist(
          lapply(variations,
                 function(y) which(grepl(pattern = y, x))))
        )
      }
    )

  def_functions <-
    unlist(lapply(seq_along(all_files),
                  function(x) all_files[[x]][def_function_index[[x]]]))

  def_functions <-
    unique(unlist(gsub(" ", "",
                       lapply(base::strsplit(def_functions, "<-"), "[[", 1))))

  # used for later adjustments of the network matrix
  def_functions2 <-
    lapply(seq_along(all_files),
           function(x) all_files[[x]][def_function_index[[x]]])

  # check for non characters
  def_functions2 <-
    lapply(def_functions2, function(x) {
      if (is.character(x)) {
        x
      } else {
        character(0)
      }
    })


  def_functions2 <-
    lapply(def_functions2,
           function(x) {
             gsub(" ", "", sapply(base::strsplit(x, "<-"), "[[", 1))
           }
    )

  def_functions2 <-
    lapply(seq_along(def_functions2),
           function(x) {
             ifelse(length(def_functions2[[x]]) == 0,
                    names(all_files)[x],
                    def_functions2[[x]])
           }
    )

  # remove function definition
  keep_lines <- mapply(function(x, y) which(!1:y %in% x),
                       def_function_index, lapply(all_files, length),
                       SIMPLIFY = FALSE)


  clean_functions <- all_files
  clean_functions <-
    lapply(seq_along(clean_functions),
           function(x) clean_functions[[x]][keep_lines[[x]]])
  names(clean_functions) <- names(all_files)

  # remove duplicated names
  dub_rows <- !duplicated(names(clean_functions))
  if (!all(dub_rows)) {
    warning(paste0("removing duplicates: ",
                   paste0(names(clean_functions)[!dub_rows], collapse = ", ")))
    clean_functions <- clean_functions[dub_rows]
    lines <- lines[dub_rows]
    all_folder <- all_folder[dub_rows]
    def_functions2 <- def_functions2[dub_rows]
  }

  # create adjacency matrix: network
  network <-
    lapply(clean_functions,
           function(z) {
             sapply(paste0(def_functions), #, "\\("
                    function(x, y = z) sum(grepl(x, y), na.rm = TRUE))
           })

  network <- as.data.frame(do.call(rbind, network))

  # adjust networks rows and columns
  names(network) <- gsub("\\\\\\(", "", names(network))
  new_collumns <- rownames(network)[
    which(!rownames(network) %in% colnames(network))]
  new_rows <- colnames(network)[
    which(!colnames(network) %in% rownames(network))]
  network[, new_collumns] <- 0
  network[new_rows, ] <- 0
  network <- network[rownames(network)]

  # adjust lines, folders
  old_names <- names(lines)
  lines <- c(lines, rep(0, length(new_rows)))
  names(lines) <- c(old_names, new_rows)

  tmp_index <- sapply(
    new_rows,
    function(y) {
      which(lapply(def_functions2, function(x) x == y) == TRUE)
    }
  )
  if (length(tmp_index) == 0) {
    tmp_index <- NULL
  }

  all_folder <- c(all_folder, all_folder[tmp_index])

  # simplify - removing functions with no connections
  if (simplify) {
    calls <- apply(1, X = network, FUN = sum) + apply(2, X = network, FUN = sum)
    keep <- which(calls != 0)
    network <- network[keep, keep]
    all_folder <- all_folder[keep]
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
  igraph::V(g1)$size   <- 10 * lines / max(lines)
  igraph::V(g1)$folder <- all_folder
  igraph::V(g1)$color  <- as.numeric(as.factor(all_folder))

  # output
  out <- list()
  out$matrix <- network
  out$igraph <- g1

  return(out)
}
