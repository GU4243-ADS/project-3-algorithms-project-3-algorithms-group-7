#############################################################
### Evaluation ###
#############################################################

### Author: Jiongjiong Li
### Project 3

##compute MAE value

mae<-function(test,prediction){
  result<-mean(abs(prediction-test),na.rm = T)
  return(result)
}

##compute ROC
# require the package "pROC"
roc<-function(test,prediction){
  library('pROC')
  result<-multiclass.roc(test, prediction)
  return(result)
}

##compute ranking scores
rank_score<-function(test,prediction,alpha=10,d=0){
  
  rank_pred<-t(apply(prediction[,-1],1,function(x){return(names(sort(x, decreasing = T)))}))
  rank_pred2<-apply(rank_pred,2,function(x){return(as.numeric(as.character(x)))})
  rank_pred<-data.frame(rank_pred2,row.names = prediction[,1])
  
  rank_test<-t(apply(test[,-1],1,function(x){return(names(sort(x, decreasing = T)))}))
  rank_test2<-apply(rank_test,2,function(x){return(as.numeric(as.character(x)))})
  rank_test<-data.frame(rank_test2,row.names = test[,1])
  
  tmp<-ifelse(test-d>0,test,0)
  R_a<-apply(tmp*(1/(2^(rank_pred-1)/(alpha-1))),1,sum)
  R<-apply(tmp[,-1]*(1/(2^(rank_test-1)/(alpha-1))),1,sum)
  
  retun(100*sum(R_a)/sum(R))
}
