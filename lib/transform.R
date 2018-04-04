# Author: Daniel J. Parker
# Source: Based on code from Group 1 Project 4 Fall 2017

#######################################
# Transform function for the MS dataset
# Input: the unprocessed MS dataset
# Output: the MS dataset processed such that:
#         every row is a user,
#         every column is an interaction node,
#         every entry is 0 if the node was not interacted with and 1 if it was.

transform_MS <- function(data) {
  user_num <- which(data$V1 == 'C')
  user_id <- data$V2[user_num]
  page_id <- unique(data$V2[which(data$V1 == 'V')])
  Table_2 <- matrix(0, nrow = length(user_id), ncol = length(page_id))
  rownames(Table_2) <- as.character(user_id)
  colnames(Table_2) <- as.character(page_id)
  for (i in 1:length(user_num)) {
    start_num <- user_num[i]
    if (i != length(user_num)) {
      end_num <- user_num[i + 1]
    }
    else {
      end_num <- nrow(data) + 1
    }
    
    user_id_mat <- as.character(user_id[i])
    
    for (j in (start_num + 1):(end_num - 1)) {
      page_id_mat <- as.character(data$V2[j])
      Table_2[user_id_mat, page_id_mat] <- 1
    }
  }
  return(Table_2)
}

##########################################
# Transform function for the Movie dataset
# Input: the unprocessed Movie dataset
# Output: the Movie dataset processed such that:
#         every row is a user,
#         every column is a movie, and
#         each entry is an integer rating 0-5, or NA.

transform_movie <- function(data) {
  columns.data <- sort(unique(data$Movie))
  rows.data <- sort(unique(data$User))
  Table_ <-
    matrix(NA,
           nrow = length(rows.data),
           ncol = length(columns.data))
  for (i in 1:length(columns.data)) {
    col.name <- columns.data[i]
    index <- which(data$Movie == col.name)
    scores <- data[index, 4] #Scores
    users <- data[index, 3] #Users
    index2 <- which(rows.data %in% users)
    Table_[index2, i] = scores
    Table_[!index2, i] = NA
  }
  colnames(Table_) <- columns.data
  rownames(Table_) <- rows.data
  return(Table_)
}

