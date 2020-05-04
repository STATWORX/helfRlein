#' @title Archive existing .RDS files
#'
#' @description This wrapper around base R \code{saveRDS()} checks if the file
#'   you attempt to save already exists. If it does, the existing file is
#'   renamed / archived (with a time stamp), and the "udpated" file will be
#'   saved under the specified name. This means that existing code which depends
#'   on the file name remaining constant (e.g., \code{readRDS()} calls in other
#'   scripts) will continue to work while an archived copy of the - otherwise
#'   overwritten - file will be kept.
#'
#'   Please note: If the file does \emph{not} already exist (i.e., if there is nothing to
#'   overwrite or archive), regular \code{\link[base]{saveRDS}} behavior will be invoked.
#'   In such a case, all arguments except \code{object} and \code{file} will be
#'   ignored!
#'
#' @param object Object to be saved
#' @param file Name of the file (path) where the R object is saved to. Note that
#'   this wrapper function does currently not support \code{connection}s.
#' @param archive Logical - should the file be archived if it already exists
#'   (default), or should it be overwritten (regular saveRDS behavior)?
#' @param last_modified Logical - should the file name of the archived file be
#'   appended with the \emph{"last modified"} date/time of the original RDS instead of
#'   the \emph{current} date/time? Defaults to \code{FALSE}.
#' @param with_time Logical - should the file be archived with just a date
#'   suffix (default) or with a date \bold{and} time suffix? Applies to both
#'   archiving and modification date. Set to \code{TRUE} if you want to keep several
#'   versions of files archived on a single day. See details.
#' @param archive_dir_path Character - if desired, path to a dedicated archive
#'   (sub-)directory (relative to the directory of \code{file}) where the
#'   archived file will be saved. Will be created if it does not yet exist.
#'   Defaults to \code{NULL}.
#' @param ... Additional arguments passed along to \code{\link[base]{saveRDS}}
#'
#' @details CAUTION: Note that existing \emph{archived versions} of files will
#'   still be overwritten if they have the same archived file name, i.e.,
#'   archived files will not be archived. This usually happens when you use only
#'   the date suffix and call this function multiple times per day: Only the
#'   most recent archived version will be kept. If you want to keep multiple
#'   archived versions of a single file, set \code{with_time} to \code{TRUE}.
#'   This will append a time stamp to the archived file name up to the current
#'   second (virtually ruling out the possibility of duplicated file names).
#'
#' @return \code{NULL} (invisibly)
#'
#' @seealso \code{\link[base]{saveRDS}}
#'
#' @examples \dontrun{
#' x <- 5
#' y <- 10
#' z <- 20
#'
#' ## save to RDS
#' saveRDS(x, "./test.RDS")
#' saveRDS(y, "./test.RDS")
#'
#' ## "test.RDS" is silently overwritten with y
#' ## previous version is lost
#' readRDS("./test.RDS")
#' #> [1] 10
#'
#' save_rds_archive(z, "./test.RDS")
#' readRDS("./test.RDS")
#' #> [1] 20
#'
#' ## previous version is archived
#' readRDS("./test_ARCHIVED_on_2020-03-30.RDS")
#' #> [1] 10
#'
#' }
#'
#' @export
#'

save_rds_archive <- function(object,
                             file = "",
                             archive = TRUE,
                             last_modified = FALSE,
                             with_time = FALSE,
                             archive_dir_path = NULL,
                             ...){

  if (file == "" | !"character" %in% class(file)){
    stop("'file' must be a non-empty character string")}

  if (!is.null(archive_dir_path) && archive_dir_path == "")
    stop("must supply a directory name to 'archive_dir_path' if not NULL")

  if (!is.logical(archive)){
    archive <- TRUE
    warning("'archive' is not set to a boolean - will use default: ", archive)
  }

  if (!is.logical(with_time)){
    with_time <- FALSE
    warning("'with_time' is not set to a boolean - will use default: ", with_time)
  }

  # IF ARCHIVE == TRUE --------------------------------------------------------

  if(archive){

    # check if file exists
    if (file.exists(file)){

      archived_file <- create_archived_file(file = file,
                                            last_modified = last_modified,
                                            with_time = with_time)

      if (!is.null(archive_dir_path)){

        # get parent directory
        dname <- dirname(file)

        # create archive dir if it does not already exist
        if(!dir.exists(file.path(dname, archive_dir_path))){
          dir.create(file.path(dname, archive_dir_path), recursive = TRUE)
          message("Created missing archive directory ", sQuote(archive_dir_path))
        }

        # change path of archived file into 'archive' folder
        archived_file <- file.path(dirname(archived_file),
                                   archive_dir_path,
                                   basename(archived_file))

        # copy (rather than rename) file
        # rename sometimes does not work if the directory itself is changed
        # save return value of the file.copy function
        # set "overwrite" to TRUE so an existing copy is overwritten (see details)

        if (file.exists(archived_file)){
          warning("Archived copy already exists - will overwrite!")
        }

        temp <- file.copy(from = file,
                          to = archived_file,
                          overwrite = TRUE)

      } else {

        if (file.exists(archived_file)){
          warning("Archived copy already exists - will overwrite!")
        }

        # rename existing file with the new name
        # save return value of the file.rename function
        # (returns TRUE if successful)
        temp <- file.rename(from = file,
                            to = archived_file)

      }

      # check return value and if archived file exists
      if (temp & file.exists(archived_file)){

        # then save new file under specified name
        saveRDS(object = object, file = file, ...)}


    } else {

      warning("Nothing to overwrite - will use regular saveRDS() behavior. ",
              "Additional arguments will be ignored!")

      # if file does not exist (but archive is set to TRUE anyways),
      # save new file under specified name
      saveRDS(object = object, file = file, ...)

    }

  } else {

    # OTHERWISE USE DEFAULT RDS -------------------------------------------------

    warning("Nothing to overwrite - will use regular saveRDS() behavior. ",
            "Additional arguments will be ignored!")

    saveRDS(object = object, file = file, ...)

  }

}
