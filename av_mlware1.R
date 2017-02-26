setwd("/home/sohom/Downloads/AV/AV_MLWARE1")

library(tm)
library(SnowballC)
library(wordcloud)
reviews_train = read.csv("train_MLWARE1.csv", stringsAsFactors = F, row.names = 1)
reviews_test= read.csv("test_MLWARE1.csv", stringsAsFactors = F, row.names = 1)
reviews_test$label=NA
reviews=rbind(reviews_train,reviews_test)

review_corpus = Corpus(VectorSource(reviews$tweet))
review_corpus = tm_map(review_corpus, content_transformer(tolower))
review_corpus = tm_map(review_corpus, removeNumbers)
review_corpus = tm_map(review_corpus, removePunctuation)
review_corpus = tm_map(review_corpus, removeWords, c("the", "and", stopwords("english")))
review_corpus =  tm_map(review_corpus, stripWhitespace)

review_dtm_tfidf <- DocumentTermMatrix(review_corpus, control = list(weighting = weightTfIdf))
review_dtm_tfidf_red = removeSparseTerms(review_dtm_tfidf, 0.9999)
dim(review_dtm_tfidf_red)
review_train_test_mat = as.matrix(review_dtm_tfidf_red)
review_train_test_df=as.data.frame(review_train_test_mat)
pos_neg_train_test<-read.csv("pos_neg_Train-Test.csv",header = TRUE)
review_train_test_df$pos=pos_neg_train_test$pos
review_train_test_df$neg=pos_neg_train_test$neg
  
labels<-ifelse(reviews_train$label=="non-sarcastic",0,1)

library(corrplot)
M <- cor(review_train_test_mat[1:nrow(reviews_train),])
corrplot(M,method="number")

train_tot_df=review_train_test_df[1:nrow(reviews_train),]

library(caTools)
set.seed(101) 
sample = sample.split(train_tot_df, SplitRatio = .90)
train_df = subset(train_tot_df, sample == TRUE)
train_labels=subset(labels, sample==TRUE)
valid_df = subset(train_tot_df, sample == FALSE)
valid_labels=subset(labels, sample==FALSE)

test_df = review_train_test_df[(nrow(reviews_train)+1):nrow(review_train_test_df),]

library(h2o)
library(data.table)
library(dplyr)



h2o.server <- h2o.init( nthreads= -1)
## Preprocessing the training data
#Converting all columns to factors
#selCols = names(train_df)
#train_1 = train_df[,(selCols) := lapply(.SD, as.factor), .SDcols = selCols]
testHex = as.h2o(test_df)
train_score1=as.factor(train_labels)
train_1 = cbind(train_df,Y=train_score1)
valid_score1=as.factor(valid_labels)
valid_1 = cbind(valid_df,Y=valid_score1)
#Converting to H2o Data frame & splitting
train.hex1 = as.h2o(train_1)
validHex1 = as.h2o(valid_1)
features=names(train.hex1)[-ncol(train.hex1)]#Removing Surge_Pricing_Type,Y i.e. the dependent variables







gbmF_model_1 = h2o.gbm( x=features,
                        y = "Y",
                        training_frame =train.hex1 ,
                        validation_frame =validHex1 ,
                        max_depth = 5,
                        #distribution = "bernoulli",
                        ntrees =200,
                        learn_rate = 0.2
                        #,nbins_cats = 5891
)

summary(gbmF_model_1)
#Variable Importances, RMSE from Validation set: Obtained from here




rf_model_1 =h2o.randomForest(x=features,y="Y",training_frame =train.hex1,
                             validation_frame =validHex1,
                             ntrees=3000,max_depth = 6)
summary(rf_model_1)
#Variable Importances, RMSE from Validation set: Obtained from here


dl_model_1 = h2o.deeplearning( x=features,
                               # x=features,
                               y = "Y",
                               training_frame =train.hex1 ,
                               validation_frame =validHex1 ,
                               activation="Rectifier",
                               hidden=80,
                               epochs=50,
                               adaptive_rate =F
)

summary(dl_model_1)
#Variable Importances, RMSE from Validation set: Obtained from here


test_pred_score1 = as.data.frame(h2o.predict(gbmF_model_1, newdata =testHex ,type="") )
pred1_1 = test_pred_score1
###ans<-lapply(pred1_1,function(x) ifelse(x<0,mean(train$total_sales),x)) #Only when some negatives are predicted
answ<-pred1_1$predict
answer<-ifelse(answ==1,"sarcastic","non-sarcastic")
fl<-cbind(as.character(row.names(reviews_test)),answer)
colnames(fl)<-c("ID","label")
write.csv(file="test_submission_tfidf_posneg_sparse_v6.csv",x=fl,row.names = F)











'''
library(xgboost)
model_xgb_cv <- xgb.cv(data=as.matrix(train_df), label=as.matrix(train_labels),missing = NaN, objective="binary:logistic", nfold=10, nrounds=1200, eta=0.02, max_depth=5, subsample=0.6, colsample_bytree=0.85, min_child_weight=1, eval_metric="rmse")




library(e1071)
model_svm<-svm(train[,2:2001],train[,2002])
model_svm_pred<-predict(model_svm,test[,2:2001])
svm_split<-sqrt(mean((model_svm_pred-test[,2002])**2))
write.csv(file="svm_split.csv",svm_split)
write.csv(file="svm_split_pred_actual.csv",cbind(model_svm_pred,test[,2002]))
model_svm_pred[model_svm_pred>.5]=1
model_svm_pred[model_svm_pred<=.5]=0
write.csv(file="svm_split_pred_actual0_1.csv",cbind(model_svm_pred,test[,2002]))
svm_split<-sqrt(mean((model_svm_pred-test[,2002])**2))
write.csv(file="svm_split0_1.csv",svm_split)
'''