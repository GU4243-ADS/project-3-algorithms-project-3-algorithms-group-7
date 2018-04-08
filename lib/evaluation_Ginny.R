#############################################################
### Evaluation ###
#############################################################

### Author: Jiongjiong Li with edits by Ginny Gao
### Project 3


setwd("/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/lib")
source("evaluation.R")


########                MS Regular                 ########

# Evaluation on MS website ratings (test vs pred)
w_test_UI <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_UI_test.RData'))


# Website: Pearson
w_pred_pearson <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred_pearson.RData'))
w_pred_pearson <- w_pred_pearson[row.names(w_pred_pearson) %in% row.names(w_test_UI), colnames(w_pred_pearson) %in% colnames(w_test_UI)]

# MAE
mae(w_test_UI, w_pred_pearson)

# ROC
roc(w_test_UI, w_pred_pearson)


# Website: Spearman
w_pred_spearman <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred_spearman.RData'))
w_pred_spearman <- w_pred_spearman[row.names(w_pred_spearman) %in% row.names(w_test_UI), colnames(w_pred_spearman) %in% colnames(w_test_UI)]

# MAE
mae(w_test_UI, w_pred_spearman)

# ROC
roc(w_test_UI, w_pred_spearman)


# Website: Cosine (VS)
w_pred_vs <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred_vs.RData'))
w_pred_vs <- w_pred_vs[row.names(w_pred_vs) %in% row.names(w_test_UI), colnames(w_pred_vs) %in% colnames(w_test_UI)]

# MAE
mae(w_test_UI, w_pred_vs)

# ROC
roc(w_test_UI, w_pred_vs)


# Website: Entropy
w_pred_entropy <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred_entropy.RData'))
w_pred_entropy <- w_pred_entropy[row.names(w_pred_entropy) %in% row.names(w_test_UI), colnames(w_pred_entropy) %in% colnames(w_test_UI)]

# MAE
mae(w_test_UI, w_pred_entropy)

# ROC
roc(w_test_UI, w_pred_entropy)


# Website: MSD
w_pred_msd <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred_msd.RData'))
w_pred_msd <- w_pred_msd[row.names(w_pred_msd) %in% row.names(w_test_UI), colnames(w_pred_msd) %in% colnames(w_test_UI)]

# MAE
mae(w_test_UI, w_pred_msd)

# ROC
roc(w_test_UI, w_pred_msd)


########                Movie Regular                 ########


# Evaluation on MOVIE ratings (test vs pred)
m_test_UI <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_UI_test.RData'))


# Movie: Pearson
m_pred_pearson <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_pearson.RData'))
m_pred_pearson <- m_pred_pearson[row.names(m_pred_pearson) %in% row.names(m_test_UI), colnames(m_pred_pearson) %in% colnames(m_test_UI)]

# MAE
mae(m_test_UI, m_pred_pearson)

# ROC
roc(m_test_UI, m_pred_pearson)


# Movie: Spearman
m_pred_spearman <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_spearman.RData'))
m_pred_spearman <- m_pred_spearman[row.names(m_pred_spearman) %in% row.names(m_test_UI), colnames(m_pred_spearman) %in% colnames(m_test_UI)]

# MAE
mae(m_test_UI, m_pred_spearman)

# ROC
roc(m_test_UI, m_pred_spearman)


# Movie: Cosine (VS)
m_pred_vs <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_vs.RData'))
m_pred_vs <- m_pred_vs[row.names(m_pred_vs) %in% row.names(m_test_UI), colnames(m_pred_vs) %in% colnames(m_test_UI)]

# MAE
mae(m_test_UI, m_pred_vs)

# ROC
roc(m_test_UI, m_pred_vs)


# Movie: Entropy
m_pred_entropy <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_entropy.RData'))
m_pred_entropy <- m_pred_entropy[row.names(m_pred_entropy) %in% row.names(m_test_UI), colnames(m_pred_entropy) %in% colnames(m_test_UI)]

# MAE
mae(m_test_UI, m_pred_entropy)

# ROC
roc(m_test_UI, m_pred_entropy)


# Movie: MSD
m_pred_msd <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_msd.RData'))
m_pred_msd <- m_pred_msd[row.names(m_pred_msd) %in% row.names(m_test_UI), colnames(m_pred_msd) %in% colnames(m_test_UI)]

# MAE
mae(m_test_UI, m_pred_msd)

# ROC
roc(m_test_UI, m_pred_msd)



########                MS Norm                 ########

# Website: Pearson (normalized rating)
w_pred_norm_pearson <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred_norm_pearson.RData'))
w_pred_norm_pearson <- w_pred_norm_pearson[row.names(w_pred_norm_pearson) %in% row.names(w_test_UI), colnames(w_pred_norm_pearson) %in% colnames(w_test_UI)]

# MAE
mae(w_test_UI, w_pred_norm_pearson)

# ROC
roc(w_test_UI, w_pred_norm_pearson)


# Website: Spearman (normalized rating)
w_pred_norm_spearman <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred_norm_spearman.RData'))
w_pred_norm_spearman <- w_pred_norm_spearman[row.names(w_pred_norm_spearman) %in% row.names(w_test_UI), colnames(w_pred_norm_spearman) %in% colnames(w_test_UI)]

# MAE
mae(w_test_UI, w_pred_norm_spearman)

# ROC
roc(w_test_UI, w_pred_norm_spearman)


# Website: Cosine (VS) (normalized rating)
w_pred_norm_vs <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred_norm_vs.RData'))
w_pred_norm_vs <- w_pred_norm_vs[row.names(w_pred_norm_vs) %in% row.names(w_test_UI), colnames(w_pred_norm_vs) %in% colnames(w_test_UI)]

# MAE
mae(w_test_UI, w_pred_norm_vs)

# ROC
roc(w_test_UI, w_pred_norm_vs)


# Website: Entropy (normalized rating)
w_pred_norm_entropy <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred_norm_entropy.RData'))
w_pred_norm_entropy <- w_pred_norm_entropy[row.names(w_pred_norm_entropy) %in% row.names(w_test_UI), colnames(w_pred_norm_entropy) %in% colnames(w_test_UI)]

# MAE
mae(w_test_UI, w_pred_norm_entropy)

# ROC
roc(w_test_UI, w_pred_norm_entropy)


# Website: MSD (normalized rating)
w_pred_norm_msd <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/MS_pred_norm_msd.RData'))
w_pred_norm_msd <- w_pred_norm_msd[row.names(w_pred_norm_msd) %in% row.names(w_test_UI), colnames(w_pred_norm_msd) %in% colnames(w_test_UI)]

# MAE
mae(w_test_UI, w_pred_norm_msd)

# ROC
roc(w_test_UI, w_pred_norm_msd)




########                Movie Norm                 ########


# Evaluation on Normalized movie ratings (test vs pred)

# Movie: Pearson (normalized rating)
m_pred_norm_pearson <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_norm_pearson.RData'))
m_pred_norm_pearson <- m_pred_norm_pearson[row.names(m_pred_norm_pearson) %in% row.names(m_test_UI), colnames(m_pred_norm_pearson) %in% colnames(m_test_UI)]

# MAE
mae(m_test_UI, m_pred_norm_pearson)

# ROC
roc(m_test_UI, m_pred_norm_pearson)


# Movie: Spearman (normalized rating)
m_pred_norm_spearman <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_norm_spearman.RData'))
m_pred_norm_spearman <- m_pred_norm_spearman[row.names(m_pred_norm_spearman) %in% row.names(m_test_UI), colnames(m_pred_norm_spearman) %in% colnames(m_test_UI)]

# MAE
mae(m_test_UI, m_pred_norm_spearman)

# ROC
roc(m_test_UI, m_pred_norm_spearman)


# Movie: Cosine (VS) (normalized rating)
m_pred_norm_vs <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_norm_vs.RData'))
m_pred_norm_vs <- m_pred_norm_vs[row.names(m_pred_norm_vs) %in% row.names(m_test_UI), colnames(m_pred_norm_vs) %in% colnames(m_test_UI)]

# MAE
mae(m_test_UI, m_pred_norm_vs)

# ROC
roc(m_test_UI, m_pred_norm_vs)


# Movie: Entropy (normalized rating)
m_pred_norm_entropy <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_norm_entropy.RData'))
m_pred_norm_entropy <- m_pred_norm_entropy[row.names(m_pred_norm_entropy) %in% row.names(m_test_UI), colnames(m_pred_norm_entropy) %in% colnames(m_test_UI)]

# MAE
mae(m_test_UI, m_pred_norm_entropy)

# ROC
roc(m_test_UI, m_pred_norm_entropy)


# Movie: MSD (normalized rating)
m_pred_norm_msd <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_norm_msd.RData'))
m_pred_norm_msd <- m_pred_norm_msd[row.names(m_pred_norm_msd) %in% row.names(m_test_UI), colnames(m_pred_norm_msd) %in% colnames(m_test_UI)]

# MAE
mae(m_test_UI, m_pred_norm_msd)

# ROC
roc(m_test_UI, m_pred_norm_msd)


