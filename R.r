################### Section 3

install.packages("rjson")
library("rjson")
json_file <- "http://www.nycgovparks.org/bigapps/DPR_Parks_001.json"
json_data <- fromJSON(file=json_file)


df <- lapply(json_data, function(play) # Loop through each "play"
{
  # Convert each group to a data frame.
  # 4 elements
  data.frame(matrix(unlist(play), ncol =4, byrow=T))
})

str(df)

# Now you have a list of data frames, connect them together in
# one single dataframe
df <- do.call(rbind, df)

# Make column names nicer, remove row names
rownames(df) <- NULL
a <- c("ID", "name", "location","ZIP")
colnames(df) <- a

df$borough <- substr(df$ID, start=1, stop=1)

result <- (table(df$borough))

barplot(result, xlab="NYC boroughs",ylab="Park businesses")
