meanSquareDiff <- function(df){
  m <- dim(df)[1] #user number
  dissim <- matrix(rep(NA, m * m), m, m)
  dissim <- data.frame(dissim)
  users <- rownames(df)
  colnames(dissim) <- users
  rownames(dissim) <- users
  for (i in 1:m){
    for (j in 1:m){
      r_i <- df[i,]
      r_j <- df[j,]
      dissim[i, j] <- mean((r_i - r_j)^2, na.rm = T)
    }
  }
  maxDissim <- max(dissim)
  sim <- (maxDissim - dissim)/maxDissim
  return (sim)
  
}

weights_MSD_train1 <- meanSquareDiff(MS_UI)
saveRDS(weights_MSD_train1, file = "weights_MSD_MS.RData")


weights_MSD_movie <- meanSquareDiff(movie_UI)
saveRDS(weights_MSD_movie, file = "weights_MSD_movie.RData") ##which are all NAs