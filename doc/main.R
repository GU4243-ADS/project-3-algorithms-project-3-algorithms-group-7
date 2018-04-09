### Authors: Group 7
### Project 3
### ADS Spring 2018


###################################################################
###     Memory-based Collaborative Filtering Algorithm Code     ###
###################################################################

########################################################
######## Building the UI matrix for the MS Data ########
########################################################

packages.used <- c('lsa', 'infotheo','pROC','matrixStats')

# check packages that need to be installed.
packages.needed <- setdiff(packages.used, intersect(installed.packages()[,1], packages.used))

# install additional packages
if(length(packages.needed) > 0) {
  install.packages(packages.needed, dependencies = TRUE, repos = 'http://cran.us.r-project.org')
}

library(lsa)
library(infotheo)

setwd("../lib")
#change source function as needed

# Which similarity weight to run
run.pearson <- TRUE
run.spearman <- FALSE
run.vs <- FALSE
run.entropy <- FALSE
run.msd <- FALSE
run.simrank <- FALSE

if (run.pearson){
source("functions_pearson.R")
}
if (run.spearman){
source("functions_spearman.R")
}
if (run.vs){
source("functions_vs.R")
}
if (run.entropy){
source("functions_entropy.R")
}
if (run.msd){
source("functions_msd.R")
}
if (run.simrank){
source("functions_simrank.R")
}


setwd("../data/MS_sample")
# Load Microsoft data
MS_train <- read.csv("data_train.csv", as.is = TRUE, header = TRUE)
MS_train <- MS_train[, 2:4] # get rid of first column: row number


# Transform from narrow to wide, i.e. user-item matrix (UI matrix)
# Using MS_data_transform function

# Below takes 2.17 minutes
MS_UI <- MS_data_transform(MS_train)
save(MS_UI, file = "../output/MS_UI.RData")


###############################################################
######## Building the UI matrix for the EachMovie Data ########
###############################################################

setwd("../data/eachmovie_sample")

# Load movie data
movie_train <- read.csv("data_train.csv", as.is = TRUE, header = TRUE)
movie_train <- movie_train[, 2:4] # get rid of first column: row number

# Compute the full matrix, below takes about 4 minutes
movie_UI <- movie_data_transform(movie_train)
save(movie_UI, file = "../output/movie_UI.RData")


#################################################################
######## Calculating the Similarity Weights of the Users ########
#################################################################


# Calculate the full similarity weights on the MS data
# Below took 30 minutes on my Macbook and 14 on my iMac

system.time(MS_sim <- calc_weight(MS_UI))
save(MS_sim, file = "../output/MS_sim.RData")


# Calculate the full similarity weights on the movie data
# Below took 87 minutes on my Macbook, 35 on my iMac

system.time(movie_sim <- calc_weight(movie_UI))
save(movie_sim, file = "../output/movie_sim.RData")


###########################################################
######## Calculating the Predictions for the Users ########
###########################################################


# Calculate predictions for MS
# This calculation took me 15 minutes

system.time(MS_pred <- pred_matrix(MS_UI, MS_sim))
save(MS_pred, file = "../output/MS_pred.RData")

# Calculate predictions for movies
# This calculation took me 2493 second

system.time(movie_pred <- pred_matrix(movie_UI, movie_sim))
save(movie_pred, file = "../output/movie_pred.RData")


#########################################################################
######## Calculating Normalized Rating Predictions for the Users ########
#########################################################################


# Calculate predictions for MS
# This calculation took me 15 minutes

system.time(MS_pred_norm <- pred_matrix_norm(MS_UI, MS_sim))
save(MS_pred_norm, file = "../output/MS_pred_norm.RData")

# Calculate predictions for movies
# This calculation took me 2493 second

system.time(movie_pred_norm <- pred_matrix_norm(movie_UI, movie_sim))
save(movie_pred_norm, file = "../output/movie_pred_norm.RData")


###########################################################
########                Evaluation                 ########
###########################################################

setwd("../lib")
# Evaluate using MAE, ROC, and ranking score
source("evaluation.R")

########                MS                 ########

w_test_UI <- get(load('../output/MS_UI_test.RData'))
w_pred_pearson <- get(load('../output/MS_pred_pearson.RData'))
rank_score(w_test_UI, w_pred_pearson)
w_pred_spearman <- get(load('../output/MS_pred_spearman.RData'))
rank_score(w_test_UI, w_pred_spearman)
w_pred_vs <- get(load('../output/MS_pred_vs.RData'))
rank_score(w_test_UI, w_pred_vs)
w_pred_entropy <- get(load('../output/MS_pred_entropy.RData'))
rank_score(w_test_UI, w_pred_entropy)
w_pred_msd <- get(load('../output/MS_pred_msd.RData'))
rank_score(w_test_UI, w_pred_msd)

########                Movie                 ########

m_test_UI <- get(load('../output/movie_UI_test.RData'))
m_pred_pearson <- get(load('../output/movie_pred_pearson.RData'))
mae(m_test_UI, m_pred_pearson)
roc(m_test_UI, m_pred_pearson)
m_pred_spearman <- get(load('../output/movie_pred_spearman.RData'))
mae(m_test_UI, m_pred_spearman)
roc(m_test_UI, m_pred_spearman)
m_pred_vs <- get(load('../output/movie_pred_vs.RData'))
mae(m_test_UI, m_pred_vs)
roc(m_test_UI, m_pred_vs)
m_pred_entropy <- get(load('../output/movie_pred_entropy.RData'))
mae(m_test_UI, m_pred_entropy)
roc(m_test_UI, m_pred_entropy)
m_pred_msd <- get(load('../output/movie_pred_msd.RData'))
mae(m_test_UI, m_pred_msd)
roc(m_test_UI, m_pred_msd)


###################################################################
###     Model-based Collaborative Filtering Algorithm Code     ###
###################################################################

########################################################
###### Building the EM Algorithm for the MS Data ######
########################################################

EM_train <- function(train, C = 3, tau = 0.04, limit_iter = 150){
  #require package"matrixStats"
  library("matrixStats")
  data<-train
  test[train == 0] <- NA
  nuser <- nrow(train)
  nwebs <- ncol(train)
  #initialization
  mu <- rep(1/C, C)
  # create a matrix to store the probabilities
  gamma1=matrix(0.5,nwebs,C)
  gamma2=matrix(0.5,nwebs,C)
  gamma<-array(NA,c(2,nwebs,C))
  gamma[1,,]<-gamma1
  gamma[2,,]<-gamma2
  #Expectation step
  #matrix generation
  #assign matrix
  assign_m <- matrix(NA, nrow = nuser, ncol = C)
  #probability
  qi <- matrix(0, nrow = nuser, ncol = C)
  flag<-1
  count <- 1
while(flag==1 & count < limit_iter){
    #compute fractional count
    for(i in 1:nuser){ 
      #find webs which users vote
      ms_observe<-as.vector(which(!is.na(train[i, ])))
      #because vote can only be 1
      vote<-rep(1,length(ms_observe))
      gamma_multi<-matrix(NA,C,length(ms_observe))
      for(j in 1:C) {
        for(m in 1:length(ms_observe)){
          gamma_multi[j,m]<-gamma[vote[m]+1,ms_observe[m],j]
        }
      }
      #print(i)
      #print("gamma_multi")
      #print(gamma_multi)
      #we get the numerator for assignment matrix
      numerator<-rowProds(gamma_multi) * mu
      #print("numerator")
      #print(numerator)
      denominator<-sum(numerator)
      assign_m[i,]<-numerator/denominator
      }
    

    #Maximization
    mu <- apply(assign_m, 2, sum)/nuser
    #since 0 multiplies anything is zero, we can just use the original data
    for(i in 1:C){ 
      for(j in 1:nwebs){
        gamma[1,j,i] <- 1-(sum(assign_m[, i] * as.vector(data[, j]))/sum(assign_m[ ,i]))

      }
    }
    
    gamma[2,,]<-1-gamma[1,,]
    if ((norm(assign_m - qi))<=tau){
      flag=0
    }
    qi <- assign_m
    count<-count+1
  return(list("assign_m" = assign_m, "gamma" = gamma))
}  
}

EM_predict<-function(train,assign_m,gamma){
  pred_mat<-train
  pred_mat[pred_mat == 0] <- NA
  for(i in 1:nrow(train)) {
    cols_to_predict <- as.vector(which(is.na(pred_mat[i, ])))
    num_cols        <- length(cols_to_predict)
    for(j in cols_to_predict){
      tmp<-assign_m[i,]*gamma[1,j,]
      pred_mat[i,j]<-sum(tmp)
    }
  }
  return(pred_mat)
}

###################################################
######## Cross Validation for the MS Data ########
###################################################

# Separate the training data
dl = nrow(MS_UI)
vl = dl/2
validation_data = train_data[1:vl,]
train_data = train_data[(vl+1):dl,]

rank_score <- function(test,prediction,alpha=5,d=0){
  #making sure the prediction and test set has the same dimensions
  prediction<-prediction[row.names(prediction)%in%row.names(test),colnames(prediction)%in%colnames(test)]
  nrow<-nrow(test)
  ncol<-ncol(test)
  rank_mat<-matrix(NA,nrow = nrow(prediction),ncol=ncol(prediction))
  # sort pred values
  rank_pred<-t(apply(prediction,1,function(x){return(names(sort(x, decreasing = T)))}))
  # sort observed values based on pred values
  for(i in 1:nrow(prediction)){
    rank_mat[i,]<-unname(test[i,][rank_pred[i,]])
  }
  row.names(rank_mat) <- row.names(prediction)
  #rank_pred<-data.frame(rank_pred2,row.names = row.names(prediction))
  
  rank_test<-t(apply(test, 1, sort,decreasing=T))
  vec<-2^(0:(ncol(prediction)-1)/(alpha-1))
  div<-matrix(rep(vec, nrow), nrow, ncol, byrow=T)
  
  tmp<-ifelse(rank_mat-d>0,rank_mat-d,0)
  #R_a formula
  R_a<-rowSums(tmp/div)
  #R_a_max formula
  R<-rowSums(rank_test/div)
  # the final score
  return(100*sum(R_a)/sum(R))
}

# Choose the range of best cluster numbers
bc <- c(2,6,8,10)

cv.accuracy<- c()
for (i in 1:length(bc)) {
  cluster_train = EM_train(train_data, C=bc[i])
  gamma1 <- cluster_train$gamma
  mu1 <- cluster_train$mu
  pi1 <- cluster_train$pi
  items1 <- cluster_train$items
  cluster_pred = EM_predict(validation_data, gamma1, mu1, pi1, items1)
  cv.accuracy[i] <- rank_score(cluster_pred, validation_data, d=0, alpha=10)
}

# observe the best parameter from the graph
plot(bc,cv.accuracy,type="b")
best_C = 6

# Test Error
best_para <- EM_train(train_data, C = best_C)
gamma2 <- best_para$gamma
assign_m<-best_para$assign_m
best_pred <- EM_predict(w_test_UI, assign_m=assign_m,gamma=gamma2)
accuracy1 <- sum(best_pred)/sum(w_test_UI)
best_rank_score <- rank_score(best_pred,w_test_UI,d=0,alpha=10)
best_rank_score
