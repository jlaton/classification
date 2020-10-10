predict.naivebayes <- function(form, train, test, varargin=NULL)
{  
  # For Naive Bayes
  library(e1071)
  
  model <- naiveBayes(form, data=train)
  prediction <- predict(model, test, type="raw")
  
  return(list(prediction[, 2], 0))
}

predict.decisiontree <- function(form, train, test, varargin=NULL)
{  
  # For Decision Tree
  library(rpart)
  
  model <- rpart(form, data=train)
  
  return(list(predict(model, test), 0))
}

predict.randomforest <- function(form, train, test, varargin = NULL)
{  
  # For Random Forest
  library(randomForest)
  
  if (length(varargin) == 0) {
    varargin = list(ntree = 500)
  }  
  model <- randomForest(formula = form, data = train, ntree = varargin$ntree)
  
  return(list(predict(model, test), 0))
}

predict.supportvector <- function(form, train, test, varargin = NULL)
{  
  # For Support Vector Machine
  library(e1071)
  
  if (length(varargin) == 0) {
    varargin <- list(tune = TRUE)
  }
  else if (length(varargin) != 3 && varargin$tune == FALSE) {
    varargin <- list(gamma = 1/ncol(train), cost = 1, tune = FALSE)
  }  
  if (varargin$tune) {
    model <- best.svm(x = form, data = train)
  }
  else {
    model <- svm(formula = form, data = train, gamma = varargin$gamma, cost = varargin$cost)
  }
  
  return(list(predict(model, test), 0))
}

predict.adaboost <- function(form, train, test, varargin=NULL)
{  
  # AdaBoost
  library(ada)
  
  if (length(varargin) == 0) {
    varargin = list(iter = 100)
  }  
  model <- ada(form, data=train, type="discrete", iter=varargin$iter)
  
  return(list(as.numeric(predict(model, test)) - 1, 0))
}

predict.optimalthreshold <- function(form, train, test, varargin = NULL)
{
  # For roc
  library(pROC)
  
  r <- roc(formula = form, data = train)
  p <- sum(train[, 2])
  n <- nrow(train) - p
  opt.thres <- r$thresholds[which.max(r$sensitivities*p + r$specificities*n)]
  
  return(list(test > opt.thres, opt.thres))
}
