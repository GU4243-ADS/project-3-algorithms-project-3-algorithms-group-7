###################################################################
### Memory-based Collaborative Filtering Algorithm Starter Code ###
###################################################################

### Authors: CIndy Rush
### Project 3
### ADS Spring 2018


MS_data_transform <- function(MS) {
  
  ## Calculate UI matrix for Microsoft data
  ##
  ## input: data   - Microsoft data in original form
  ##
  ## output: UI matrix
  
  
  # Find sorted lists of users and vroots
  users  <- sort(unique(MS$V2[MS$V1 == "C"]))
  vroots <- sort(unique(MS$V2[MS$V1 == "V"]))
  
  nu <- length(users)
  nv <- length(vroots)
  
  # Initiate the UI matrix
  UI            <- matrix(0, nrow = nu, ncol = nv)
  row.names(UI) <- users
  colnames(UI)  <- vroots
  
  user_locs <- which(MS$V1 == "C")
  
  # Cycle through the users and place 1's for the visited vroots.
  for (i in 1:nu) {
    name     <- MS$V2[user_locs[i]]
    this_row <- which(row.names(UI) == name)
    
    # Find the vroots
    if (i == nu) {
      v_names <- MS$V2[(user_locs[i] + 1):nrow(MS)]
    } else {
      v_names <- MS$V2[(user_locs[i] + 1):(user_locs[i+1] - 1)]
    }  
    
    # Place the 1's
    UI[this_row, colnames(UI) %in% v_names] <- 1
  }
  return(UI)
}



movie_data_transform <- function(movie) {
  
  ## Calculate UI matrix for eachmovie data
  ##
  ## input: data   - movie data in original form
  ##
  ## output: UI matrix

  
  # Find sorted lists of users and vroots
  users  <- sort(unique(movie$User))
  movies <- sort(unique(movie$Movie))
  
  # Initiate the UI matrix
  UI            <- matrix(NA, nrow = length(users), ncol = length(movies))
  row.names(UI) <- users
  colnames(UI)  <- movies
  
  # We cycle through the users, finding the user's movies and ratings
  for (i in 1:length(users)) {
    user    <- users[i]
    movies  <- movie$Movie[movie$User == user]
    ratings <- movie$Score[movie$User == user]
    
    ord     <- order(movies)
    movies  <- movies[ord]
    ratings <- ratings[ord]
    
    # Note that this relies on the fact that things are ordered
    UI[i, colnames(UI) %in% movies] <- ratings
  }
  return(UI)
}  



## simrank weights
# returns the corresponding row or column for a user or movie.
get_movies_num <- function(user){
  u_i <- match(user, users)
  return(graph[u_i,-1])
}

get_users_num <- function(movie){
  m_j <- match(movie, movies)
  return(graph[,m_j+1])
}


# return the users or movies with a non zero
get_movies <- function(user){
  series = get_movies_num(user)
  return(movies[which(series!=0)])
}

get_users <- function(movie){
  series = get_users_num(movie)
  return(users[which(series!=0)])
}

user_simrank <- function(u1, u2, C) {
  if (u1 == u2){
    return(1)
  } else {
    pre = C / (sum(get_movies_num(u1)) * sum(get_movies_num(u2)))
    post = 0
    for (m_i in get_movies(u1)){
      for (m_j in get_movies(u2)){
        i <- match(m_i, movies)
        j <- match(m_j, movies)
        post <- post + movie_sim[i, j]
      }
    }
    return(pre*post)
  }
}

movie_simrank <- function(m1, m2, C) {
  if (m1 == m2){
    return(1)
  } else {
    pre = C / (sum(get_users_num(m1)) * sum(get_users_num(m2)))
    post = 0
    for (u_i in get_users(m1)){
      for (u_j in get_users(m2)){
        i <- match(u_i, users)
        j <- match(u_j, users)
        post <- post + user_sim[i, j]
      }
    }
    return(pre*post)
  }
}

simrank <- function(C=0.8, times = 1, calc_user = T, calc_movie = F, data){
  
  for (run in 1:times){
    
    if(calc_user){
      for (ui in users){
        for (uj in users){
          i = match(ui, users)
          j = match(uj, users)
          user_sim[i, j] <<- user_simrank(ui, uj, C)
        }
      }
    }
    if(calc_movie){
      for (mi in movies){
        for (mj in movies){
          i = match(mi, movies)
          j = match(mj, movies)
          movie_sim[i, j] <<- movie_simrank(mi, mj, C)
        }
      }
    }
  }
}





pred_matrix <- function(data, simweights) {
  
  ## Calculate prediction matrix
  ##
  ## input: data   - movie data or MS data in user-item matrix form
  ##        simweights - a matrix of similarity weights
  ##
  ## output: prediction matrix
  
  # Initiate the prediction matrix.
  pred_mat <- data
  
  # Change MS entries from 0 to NA
  pred_mat[pred_mat == 0] <- NA
  
  row_avgs <- apply(data, 1, mean, na.rm = TRUE)
  
  for(i in 1:nrow(data)) {
    
    # Find columns we need to predict for user i and sim weights for user i
    cols_to_predict <- which(is.na(pred_mat[i, ]))
    num_cols        <- length(cols_to_predict)
    neighb_weights  <- simweights[i, ]
    
    # Transform the UI matrix into a deviation matrix since we want to calculate
    # weighted averages of the deviations
    dev_mat     <- data - matrix(rep(row_avgs, ncol(data)), ncol = ncol(data))
    weight_mat  <- matrix(rep(neighb_weights, ncol(data)), ncol = ncol(data))
    
    weight_sub <- weight_mat[, cols_to_predict]
    dev_sub    <- dev_mat[ ,cols_to_predict]
    
    pred_mat[i, cols_to_predict] <- row_avgs[i] +  apply(dev_sub * weight_sub, 2, sum, na.rm = TRUE)/sum(neighb_weights, na.rm = TRUE)
#    print(i)
  }
  
  return(pred_mat)
}








pred_matrix_norm <- function(data, simweights) {
  
  ## Calculate normalized prediction matrix
  ##
  ## input: data   - movie data or MS data in user-item matrix form
  ##        simweights - a matrix of similarity weights
  ##
  ## output: prediction matrix
  
  # Initiate the prediction matrix.
  pred_mat <- data
  
  # Change MS entries from 0 to NA
  pred_mat[pred_mat == 0] <- NA
  
  # Calculate average of the rows, less NA
  row_avgs <- apply(data, 1, mean, na.rm = TRUE)
  # Calculate standard deviation of the rows, less NA
  row_sd <- apply(data, 1, sd, na.rm = TRUE)
  
  for(i in 1 : nrow(data)) {
    
    # Find columns we need to predict for user i
    cols_to_predict <- which(is.na(pred_mat[i, ]))
    num_cols        <- length(cols_to_predict)
    # Find sim weights for user i
    neighb_weights  <- simweights[i, ]
    
    # Transform the UI matrix into a deviation (from row means) matrix since we want to calculate
    # weighted averages of the deviations
    dev_mat     <- data - matrix(rep(row_avgs, ncol(data)), ncol = ncol(data))
    zScore_mat  <- dev_mat/matrix(rep(row_sd, ncol(data)), ncol = ncol(data))
    weight_mat  <- matrix(rep(neighb_weights, ncol(data)), ncol = ncol(data))

    # Subsets withs columns to predict, which is ones with NAs
    dev_sub    <- dev_mat[ ,cols_to_predict]
    zScore_sub <- zScore_mat[, cols_to_predict]
    weight_sub <- weight_mat[, cols_to_predict]
    
    pred_mat[i, cols_to_predict] <- row_avgs[i] +  apply(zScore_sub * weight_sub, 2, sum, na.rm = TRUE)/sum(neighb_weights, na.rm = TRUE)
#    print(i)
  }
  
  return(pred_mat)
}



