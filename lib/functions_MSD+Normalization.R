selectNeighborWeights <- function(df, weights, n){
  users <- rownames(df)
  m <- length(users)
  neighbors <- matrix(rep(NA, m * n), m, n)
  neighors <- data.frame(neighbors)
  rownames(neighbors) <- users
  
  for (i in 1:m){
    neighbors[i, ] <- colnames(weights)[order(weights[i, ], decreasing=TRUE)][1:n]
  }
  return (neighbors)
}

computeZScore <- function(weights, neighbors, df, a, i){
  neighbors_a <- neighbors[toString(a), ] 
  num <- rep(0, length(neighbors_a))
  for (u in 1:length(neighbors_a)){
    neighborU <- neighbors_a[u] 
    r_ui <- df[toString(neighborU), toString(i)]
    r_u <- mean(df[neighborU, ], na.rm = T)
    sd_u <- sd(df[neighborU, ], na.rm = F)
    w_au <- weights[toString(a), neighborU]
    num[u] <- (r_ui - r_u)/sd_u * w_au
  }
  w_a <- sum(weights[toString(a), neighbors_a])
  sd_a <- sd(df[toString(a), ])
  index_not_i <- colnames(df) != i
  r_a <- mean(df[toString(a), index_not_i])
  p_ai <- r_a + sd_a * sum(num)/w_a
  return (p_ai)
}

computeZScoreMatrix <- function(weights, neighbors, df, df_test){
  a <- dim(df_test)[1]
  b <- dim(df_test)[2]
  users <- rownames(df_test)
  website <- colnames(df_test)
  computeZScoreMatrix <- matrix(rep(0, a * b), a, b)
  for (i in 1:a){
    for (j in 1:b){
      ##if (is.na(df_test[i, j]) == F){ #data2
      if (df_test[i, j] != 0){ data1
        computeZScoreMatrix[i, j] <- computeZScore(weights, neighbors, df, users[i], website[j])
      }
      #computeZScoreMatrix[i, j] <- computeZScore(weights, neighbors, df, users[i], website[j])
    }
  }
  return (computeZScoreMatrix)
}

##MSD
neighbors_MSD_train1 <- selectNeighborWeights(MS_UI, weights_MSD_train1 , 20)
neighbors_MSD_train2 <- selectNeighborWeights(train2, weights_MSD_train2, 20)
ZScoreMatrix_MSD_test1 <- computeZScoreMatrix(weights_MSD_train1, neighbors_MSD_train1, MS_UI,test1)
ZScoreMatrix_MSD_test2 <- computeZScoreMatrix(weights_MSD_train2, neighbors_MSD_train2, train2,test2)

save(ZScoreMatrix_MSD_train1, file="Normalization+MSD_MS.RData")
