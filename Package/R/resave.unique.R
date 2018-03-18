#' @title Save only unique data
#' 
#' @description
#' Function to regoranize large unorganized filse into multiple new
#' files based on categorical variable.
#' 
#' Function in its current state is generated for MS specific use,
#' but could be generalized.
#'
#' @param dt a data.table
#' @param name 
#' @param unique.test 
#' @param unique.fac 
#' @param path a path where the data is saved.
#'
#' @export
#'
#' @examples
#' 
#' 

resave_unique <- function(dt,
                          name = NA,
                          unique.test = TRUE,
                          unique.fac = NULL,
                          path = ".") {
  
  # check if dt is a data.table
  if(!data.table::is.data.table(dt)) {
    stop("dt must be a data.table")
  }
  
  # Search for files in desination folder
  files2 <- list.files(path = path)
  
  # Find file relevant file 
  existend <- which(files2 == name)
  
  # Saving process when related data already existis
  if(length(existend) >= 1) {
    dt_new <- dt 
    #savedObject <- get(readRDS(name))
    savedObject <- readRDS(paste0(path, name))
    print(nrow(savedObject))
    dt <- rbind(savedObject, dt_new)
    print(nrow(dt))
    if(unique.test == TRUE) {
      data.table::setkeyv(dt, unique.fac)
      dt <- unique(dt)
    }
    saveRDS(dt, file =  paste0(path, name))
    # Saving process if no file is available  
  } else {
    saveRDS(dt, file =  paste0(path, name))
  }
}