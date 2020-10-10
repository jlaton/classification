rate.predictions <- function(predictions, threshold = 0.5)
{
  # This function takes the output from either crossvalidate or multi.crossvalidate
  # and returns the amount of true/false positives/negatives for each
  # crossvalidation run.
  # Its result can be input into interpret.ratings.
  
  predictions <- predictions$Predictions
  
  real.class <- data.frame(rep(predictions[ncol(predictions)], ncol(predictions) - 1))
  predictions <- predictions[-ncol(predictions)]
  
  predictions[predictions < threshold] <- 0
  predictions[predictions >= threshold] <- 1
  
  TP <- colSums(predictions & real.class)
  TN <- colSums(!predictions & !real.class)
  FN <- colSums(!predictions & real.class)
  FP <- colSums(predictions & !real.class)

  return(data.frame(TP, TN, FN, FP))
}