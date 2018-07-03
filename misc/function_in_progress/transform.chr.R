# Function to ttransform characters to numerics

# data <- data.table(V1 = letters[1:3],
#                  V2 = 1:3,
#                  V3 = c("1", "2", "3"))


transform.chr <- function(data) {
  
  changeCols <- colnames(data)[which(as.vector(data[,lapply(.SD, class)]) == "character")]
  
  data[,(changeCols):= lapply(.SD, as.numeric), .SDcols = changeCols]
}


# Ideas ------
# Identfy actually numeric variables that have been put in as strings
# Add systemic way to deal with factors

# functions is not yet complete, because actual strings will become NAs
# colnames for data.table is not needed, names is enough
