multi.crossvalidate <- function(predict.classifier, data, K = 10, n.iter = 100, varargin = NULL)
{
  # This function executes crossvalidate n.iter times and returns a table of
  # predictions, with a column for each crossvalidation run.
  # See crossvalidate for more info.
  
  predictions <- data[ncol(data)]
  parameters <- data.frame()
  
  for (i in 1 : n.iter) {
    cat("Iteration", i, "/", n.iter, "\n")
    res <- crossvalidate(predict.classifier, data, K, varargin)
    parameters <- rbind(parameters, res[[2]])
    predictions <- cbind(res[[1]][1], predictions)
  }
  
  colnames(predictions) <- c(paste("prediction", 1:n.iter), "true.class")
  colnames(parameters) <- paste("fold", 1:K)
  
  return(list(Predictions = predictions, Parameters = parameters))
}
