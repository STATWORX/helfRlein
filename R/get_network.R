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
#' @param verbose a boolean setting the debugging prints.
#'
#' @return
#'   Returns an object with the adjacency matrix \code{$matrix},
#'   an igraph object \code{$igraph}, a table for the edges \code{$edge_dt},
#'   a table for the nodes \code{$node_dt} and
#'   a networkD3 plot \code{$networkD3}.
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
                        exclude = NULL,
                        verbose = FALSE) {

  # check if dir exists
  if (!is.null(dir) && all(!dir.exists(dir))) {
    stop(paste0(dir, " does not exists"))
  }

  if (is.null(all_scripts)) {
    # get files and folder within dir
    files_path <- list.files(file.path(dir),
                             pattern = pattern,
                             recursive = TRUE,
                             full.names = TRUE)


    # removing files with exclude input
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

    common_base_path <- function(paths) {
      # Split each path into its components
      split_paths <- strsplit(paths, "/")

      # Find the common path
      common_path <- Reduce(function(x, y) {
        # Get the length of the shorter vector
        min_length <- min(length(x), length(y))
        # Only compare the elements up to the length of the shorter vector
        common <- x[seq_len(min_length)] == y[seq_len(min_length)]
        # If there's a FALSE in common, only keep the elements before it
        if (any(!common)) x[seq_len(which(!common)[1] - 1)]
        else x
      }, split_paths)

      # Combine the common path components back into a single string
      common_path <- paste(common_path, collapse = "/")

      return(common_path)
    }

    dir_base <- common_base_path(paths = dir)


    folder <- dirname(gsub(paste0(dir_base, "/"), "", files_path))

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

  if (verbose) {
    print(paste0("found ", length(all_scripts), " scripts"))
    print(paste0("length of folder: ", length(folder)))
  }

  # check for empty scripts
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
  # otherwise the regular expression will be messed up later
  keep <- !startsWith(names(all_scripts), "[")
  if (verbose && any(!keep)) {
    print(paste0("remove method / functions that start with [: ",
                 sum(!keep)))
  }
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

  # check for empty scripts
  indx <- sapply(all_scripts, length) == 0
  if (any(indx)) {
    warning(paste0("removing empty scritps: ",
                   paste0(names(all_scripts)[indx], collapse = ", ")))
    all_scripts <- all_scripts[!indx]
    folder <- folder[!indx]
  }

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

  # check for empty scripts
  indx <- sapply(all_scripts, length) == 0
  if (any(indx)) {
    warning(paste0("removing empty scritps: ",
                   paste0(names(all_scripts)[indx], collapse = ", ")))
    all_scripts <- all_scripts[!indx]
    folder <- folder[!indx]
  }

  # filter only those with functions (variations) in it
  index_functions <- unique(unlist(sapply(variations, grep, all_scripts)))
  main_functions  <- all_scripts[index_functions]
  folder_main     <- folder[index_functions]
  scripts         <- all_scripts[-index_functions]
  folder_scripts  <- folder[-index_functions]

  if (verbose) {
    print(c(
      paste0("found ", length(index_functions),
             " scripts containing: '",
             paste0(variations, collapse = "', '"), "'"),
      paste0("main_functions: ", length(main_functions),
             " in folder_main: ", length(folder_main)),
      paste0("scripts: ", length(scripts),
             " in folder_scripts: ", length(folder_scripts))
    ))
  }

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
  folder_index <- which(names(main_functions) %in% names(sub_index))
  folder_sub <- rep(folder_main[folder_index], sapply(sub_index, nrow))

  if (verbose) {
    print(paste0(
      "check length: ", length(sub_functions), " sub-functions in ",
      length(folder_sub), " folders"

    ))
  }

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

  if (verbose) {
    print(paste0(
      "check length: ", length(all_functions), " all_functions in ",
      length(all_folder), " all_folder"
    ))
  }


  # remove duplicates
  index <- !duplicated(all_functions)
  all_functions <- all_functions[index]
  all_folder    <-  all_folder[index]
  if (verbose) {
    print(paste0("number of duplicated functions: ", sum(!index)))
  }

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

  if (verbose) {
    print(paste0(
      "check length: ", length(all_files), " all_files in ",
      length(all_folder), " all_folder"
    ))
  }

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

  def_functions <- lapply(
    seq_along(all_files),
    function(x) all_files[[x]][def_function_index[[x]]]
    )
  tmp_def_idx <- sapply(def_functions, function(x) length(x) == 0)
  def_functions[tmp_def_idx] <- ""


  def_functions[!tmp_def_idx] <- gsub(
    pattern = " ",
    replacement = "",
    lapply(base::strsplit(unlist(def_functions[!tmp_def_idx]), "<-"), "[[", 1))

  tmp_def_idx2 <- def_functions == "" & !tmp_def_idx
  # check for empty entries
  if (any(tmp_def_idx2)) {
    warning(paste0("Missing function name. ",
                   "This would have led to missleading plots. ",
                   "Removed from script(s): '",
                   paste0(names(all_files)[tmp_def_idx2],
                          collapse = "', '"), "'"))
  }
  def_functions <- unique(unlist(
    def_functions[def_functions != "" & !tmp_def_idx]
    ))



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

  if (verbose) {
    print(paste0(
      "check length: ", length(clean_functions), " clean_functions in ",
      length(all_folder), " all_folder"
    ))
  }

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

  if (verbose) {
    print(paste0(
      "initial network has ", nrow(network), " rows and ",
      ncol(network), " cols"
    ))
  }

  # adjust networks rows and columns
  names(network) <- gsub("\\\\\\(", "", names(network))
  new_columns <- rownames(network)[
    which(!rownames(network) %in% colnames(network))]
  new_rows <- colnames(network)[
    which(!colnames(network) %in% rownames(network))]
  network[, new_columns] <- 0
  network[new_rows, ] <- 0
  network <- network[rownames(network)]
  if (verbose) {
    print(c(
      paste0("adding ", length(new_rows), " new rows"),
      paste0("adding ", length(new_columns), " new cols"),
      paste0("adjusted network has ", nrow(network), " rows and ",
             ncol(network), " cols")
    ))
  }



  # adjust lines, folders
  old_names <- names(lines)
  lines <- c(lines, rep(0, length(new_rows)))
  names(lines) <- c(old_names, new_rows)
  if (verbose) {
    print(paste0("check length: ", length(lines), " lines"))
  }


  # remove duplicated functions within def_functions2
  if (sum(duplicated(def_functions2)) > 0 && verbose) {
    print(paste0("There are ", sum(duplicated(def_functions2)),
                 " inner functions with the same name.",
                 " Keeping only the first"))
  }

  tmp_index <- unlist(lapply(
    new_rows,
    function(y) {
      which(lapply(def_functions2, function(x) x == y) == TRUE)[1]
    }
  ))
  if (length(tmp_index) == 0) {
    tmp_index <- NULL
  }

  all_folder <- c(all_folder, all_folder[tmp_index])
  if (verbose) {
    print(paste0("check length: ", length(all_folder), " all_folder"))
  }

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

  # add interative plot with networkD3 package

  edge_dt <- data.frame(
    target = rep(rownames(network), each = ncol(network)),
    source = rep(colnames(network), times = nrow(network)),
    value = unlist(network),
    stringsAsFactors = FALSE,
    row.names = NULL
  )
  edge_dt <- edge_dt[edge_dt$value != 0, ]

  # needs to start with 0 index instead of 1
  edge_dt$source <- match(edge_dt$source, rownames(network)) - 1
  edge_dt$target <- match(edge_dt$target, rownames(network)) - 1

  node_dt <- data.frame(
    "label" = factor(x = names(lines), levels = rownames(network)),
    "size" = 10 * lines / max(lines),
    "folder" = all_folder,
    "color" = as.numeric(as.factor(all_folder)),
    row.names = NULL,
    stringsAsFactors = FALSE)

if (nrow(edge_dt) == 0 || nrow(node_dt) == 0) {
  print("No relations could be found!")
  net_plot <- NULL
} else {
  net_plot <- networkD3::forceNetwork(
    Links = edge_dt, # data.frame with source, target, value
    Nodes = node_dt, # data.frame with node infos
    Source = "source",
    Target = "target",
    Value = "value",
    NodeID = "label",
    Nodesize = "size",
    #radiusCalculation = "Math.sqrt(d.nodesize)+6",
    # linkDistance = networkD3::JS("function(d) { return 50*d.value; }"),
    linkDistance = 100,
    fontSize = 10,
    Group = "folder",
    opacity = 0.8,
    opacityNoHover = 0.5,
    legend = TRUE,
    zoom = TRUE,
    arrows = TRUE)
}


  # output
  out <- list(
  "matrix" = network,
  "igraph" = g1,
  "node_dt" = node_dt,
  "edge_dt" = edge_dt,
  "networkD3" = net_plot
  )

  return(out)
}
