
###################################################################
### Memory-based Collaborative Filtering Algorithm Starter Code ###
###################################################################

### Authors: Cindy Rush with edits by Ginny Gao
### Project 3
### ADS Spring 2018


########################################################
######## Building the UI matrix for the MS Data ########
########################################################

packages.used <- c('lsa', 'infotheo')

# check packages that need to be installed.
packages.needed <- setdiff(packages.used, intersect(installed.packages()[,1], packages.used))

# install additional packages
if(length(packages.needed) > 0) {
  install.packages(packages.needed, dependencies = TRUE, repos = 'http://cran.us.r-project.org')
}

library(lsa)
library(infotheo)

setwd("/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/lib")

#change source function as needed
source("functions.R")


setwd("/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/data/MS_sample")

# Load the Microsoft MS data
MS_train <- read.csv("data_train.csv", as.is = TRUE, header = TRUE)
MS_train <- MS_train[, 2:4] # get rid of first column: row number


# Transform from narrow to wide, i.e. user-item matrix (UI matrix)
# Using MS_data_transform function

# Below takes 2.17 minutes
MS_UI <- MS_data_transform(MS_train)
#object.size(MS_UI <- MS_data_transform(MS_train))
save(MS_UI, file = "/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_UI.RData")


# Matrix Calculations
# Number of pages visited for each user
visit_nums <- rowSums(MS_UI != 0)

# Frequency count of how many users visited 6, 7, 8, etc pages, histogram
table(visit_nums)

# Mean of number of pages visted among users
mean(visit_nums)

# Median of number of pages visted among users
median(visit_nums)


###############################################################
######## Building the UI matrix for the EachMovie Data ########
###############################################################

setwd("/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/data/eachmovie_sample")

# Load the data
movie_train <- read.csv("data_train.csv", as.is = TRUE, header = TRUE)
movie_train <- movie_train[, 2:4] # get rid of first column: row number


# Compute the full matrix
# Below takes about 4 minutes

movie_UI <- movie_data_transform(movie_train)
#object.size(movie_UI <- movie_data_transform(movie_train))
save(movie_UI, file = "/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_UI.RData")

# Some calculations
total_ratings <- rowSums(movie_UI, na.rm = TRUE)

table(total_ratings)
mean(total_ratings)
median(total_ratings)


#################################################################
######## Calculating the Similarity Weights of the Users ########
#################################################################


# Calculate the full similarity weights on the movie data
# The below took 87 minutes on my Macbook, 35 on my iMac

system.time(movie_sim <- calc_weight(movie_UI))
#object.size(movie_sim <- calc_weight(movie_UI))
save(movie_sim, file = "/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_sim.RData")


# Calculate the full similarity weights on the MS data
# The below took 30 minutes on my Macbook and 14 on my iMac


system.time(MS_sim <- calc_weight(MS_UI))
#object.size(MS_sim <- calc_weight(MS_UI))
save(MS_sim, file = "/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_sim.RData")


###########################################################
######## Calculating the Predictions for the Users ########
###########################################################


# Calculate predictions for MS
# This calculation took me 15 minutes

system.time(MS_pred <- pred_matrix(MS_UI, MS_sim))
#object.size(MS_pred <- pred_matrix(MS_UI, MS_sim))
save(MS_pred, file = "/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred.RData")

# Calculate predictions for movies
# This calculation took me 2493 second

system.time(movie_pred <- pred_matrix(movie_UI, movie_sim))
#object.size(movie_pred <- pred_matrix(movie_UI, movie_sim))
save(movie_pred, file = "/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred.RData")
