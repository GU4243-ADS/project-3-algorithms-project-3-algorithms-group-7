#############################################################
### Evaluation ###
#############################################################

### Author: Jiongjiong Li
### Project 3

##compute MAE value

m_test_UI <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_UI_test.RData'))

m_pred_pearson <- get(load('/Users/qinqingao/Documents/GitHub/project-3-algorithms-project-3-algorithms-group-7/output/movie_pred_pearson.RData'))
m_pred_pearson <- m_pred_pearson[row.names(m_pred_pearson) %in% row.names(m_test_UI), colnames(m_pred_pearson) %in% colnames(m_test_UI)]


mae<-function(test,prediction){
  result<-mean(abs(prediction-test),na.rm = T)
  return(result)
}


mae(m_test_UI, m_pred_pearson)


##compute ROC
# require the package "pROC"
roc<-function(test,prediction){
  library('pROC')
  result<-multiclass.roc(test, prediction)
  return(result)
}

roc(m_test_UI, m_pred_pearson)


##compute ranking scores
rank_score<-function(test,prediction,alpha=5,d=0){
  prediction<-prediction[row.names(prediction)%in%row.names(test),colnames(prediction)%in%colnames(test)]
  #rank_pred<-t(apply(prediction[,-1],1,function(x){return(names(sort(x, decreasing = T)))}))
  rank_pred<-t(apply(prediction,1,function(x){return(names(sort(x, decreasing = T)))}))
  rank_pred2<-apply(rank_pred,2,function(x){return(as.numeric(as.character(x)))})
  rank_pred<-data.frame(rank_pred2,row.names = row.names(prediction))
  
  #rank_test<-t(apply(test[,-1],1,function(x){return(names(sort(x, decreasing = T)))}))
  rank_test<-t(apply(test,1,function(x){return(names(sort(x, decreasing = T)))}))
  rank_test2<-apply(rank_test,2,function(x){return(as.numeric(as.character(x)))})
  rank_test<-data.frame(rank_test2,row.names = row.names(test))
  
  tmp<-ifelse(test-d>0,test-d,0)
  R_a<-apply(tmp*(1/(2^(rank_pred-1)/(alpha-1))),1,sum)
  R<-apply(tmp*(1/(2^(rank_test-1)/(alpha-1))),1,sum)
  
  return(100*sum(R_a)/sum(R))
}
