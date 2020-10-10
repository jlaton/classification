crossvalidate <- function(predict.classifier, data, K=10, varargin=NULL)
{
  # This functions crossvalidates the classifier given the data.
  # Parameters:
  # predict.classifier is one of the classifier wrappers
  # data is a data.frame containing all the attributes. The last column is used
  #   as class, or dependent variable.
  # K is number of folds, setting K=0 yields leave-one-out crossvalidation
  # varargin can contain an optional setting for specific classifier wrappers,
  #   see there for more info.

  # For cvFolds
  library(cvTools)
  # For as.simple.formula
  library(FSelector)
  
  # K-fold CV, K=0 yields leave-one-out crossvalidation
  if (K == 0) {
    K <- nrow(data)
  }
  folds <- cvFolds(nrow(data), K=K)
  
  # trick to create generic formula
  # last column is class, all others are attributes
  cols <- colnames(data)
  attributes = cols[1:(length(cols) - 1)]
  class = tail(cols, 1)
  form = as.simple.formula(attributes, class)
  
  # keep track of original values and predictions
  real.class <- data[, ncol(data)]
  prediction <- vector(length = nrow(data))
  parameters <- vector(length = K)
  
  cat("Fold:\t")
  
  for (i in 1:K) {
    cat(i, " ")
    train <- data[folds$subsets[folds$which != i], ]
    test <- data[folds$subsets[folds$which == i], -ncol(data)]
    res <- predict.classifier(form, train, test, varargin)
    prediction[folds$subsets[folds$which == i]] <- res[[1]]
    parameters[i] <- res[[2]]
  }
  
  cat("\n")
  
  parameters <- rbind(data.frame(), parameters)
  colnames(parameters) <- paste("fold", 1:K)
  
  return(list(Predictions = data.frame(prediction, real.class), Parameters = parameters))
}