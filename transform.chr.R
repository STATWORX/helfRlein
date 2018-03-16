# Function to ttransform characters to numerics

transform.chr <- function(data) {
  
  changeCols <- colnames(data)[which(as.vector(data[,lapply(.SD, class)]) == "character")]
  
  data[,(changeCols):= lapply(.SD, as.numeric), .SDcols = changeCols]
}


# Ideas ------
# Identfy actually numeric variables that have been put in as strings
# Add systemic way to deal with factors