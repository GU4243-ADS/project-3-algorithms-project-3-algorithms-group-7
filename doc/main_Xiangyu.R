source(functions_meansquare.R)
source(functions_MSD+Normalization.R)
source(functions_simrank.R)

#Mean squard deviation
##calulate the MSD weights for MS data
weights_MSD_train1 <- meanSquareDiff(MS_UI)
saveRDS(weights_MSD_train1, file = "weights_MSD_MS.RData")

##calculate the MSD weights for movie data
weights_MSD_movie <- meanSquareDiff(movie_UI)
saveRDS(weights_MSD_movie, file = "weights_MSD_movie.RData") ##which are all NAs

#Simrank
##calulate the simrank matirx for movie data
if(model.sim.rank){
  graph <- movie_UI[1:1000, 1:1000]
  
  graph[is.na(graph)] <- 0
  
  graph[,-1][graph[,-1] < 5] <- 0
  graph[,-1][graph[,-1] >= 5] <- 1
  
  calc_user = T
  calc_movie = F
  
  user_sim <- diag(dim(graph)[1])
  movie_sim <- diag(dim(graph)[2])
  
  users <- graph[,1]
  movies <- colnames(graph[,-1])
  
  simrank(0.8, 1)
  
  colnames(user_sim) <- users
  user_sim <- cbind(users, user_sim)
  write.csv(user_sim, file='../output/usersim.csv', row.names = FALSE)
}

##predict simrank ratings on movie data
load("output/weights_SimRank_movie")
movie_pred_simrank <- pred_matrix(movie_UI, weights_SimRank_movie)


##transform the matrix in order to do the evaluation
rownames(movie_pred_simrank)<- rownames(movie_UI)
colnames(movie_pred_simrank)<- colnames(movie_UI)
movie_pred_simrank<-cbind(rownames(movie_UI),movie_pred_simrank)

save(movie_pred_simrank, file="movie_pred_simrank.RData")

#MSD+Normalization
##predict ratings using normalization+MSD on MS data
neighbors_MSD_MS <- selectNeighborWeights(MS_UI, weights_MSD_MS , 20)
ZScoreMatrix_MSD_MS <- computeZScoreMatrix(weights_MSD_train1, neighbors_MSD_MS, MS_UI,test1)

##predict ratings using normalization+MSD on MS data
neighbors_MSD_movie <- selectNeighborWeights(movie_UI, weights_MSD_movie, 20)
ZScoreMatrix_MSD_movie <- computeZScoreMatrix(weights_MSD_train2, neighbors_MSD_movie, movie_UI,test2)

##transform the matrix in order to do the evaluation
rownames(ZScoreMatrix_MSD_train1)<- rownames(MS_UI)
colnames(ZScoreMatrix_MSD_train1)<- colnames(MS_UI)
ZScoreMatrix_MSD_train1<-cbind(rownames(MS_UI),ZScoreMatrix_MSD_train1)
colnames(ZScoreMatrix_MSD_train1)[1] <- "User"

save(ZScoreMatrix_MSD_train1, file="MS_pred_Normalization_MSD.RData")

