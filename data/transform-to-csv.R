
# Instructions ----------------
# This script transforms leetcode json data format into csv format.
#
# Type in below in Terminal to use this script:
#   Rscript --vanilla transform-to-csv.R your-json-file-name-without-json-extension
#
# For example:
#   Rscript --vanilla transform-to-csv.R data-1141

# Process --------------------

args = commandArgs(trailingOnly=TRUE)

library(rjson)

path = "~/Projects/leetcode/data/"
setwd(path)

json.file = args[1]

result = rjson::fromJSON(file = paste(json.file, ".json", sep = ""))

data.by.row = result[["rows"]][[1]]
df.result =
  data.frame(matrix(unlist(data.by.row), 
                    nrow = length(data.by.row), 
                    byrow = TRUE),
             stringsAsFactors = FALSE)
colnames(df.result) = result[[1]][[1]]

write.csv(df.result, paste(json.file, ".csv", sep = ""), row.names = FALSE,
          quote = TRUE)
