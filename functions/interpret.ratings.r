interpret.ratings <- function(ratings)
{
  # This function takes the output of rate.predictions and returns the means and
  # the standard deviations of accuracy, sensitivity, specificity, positive
  # predictive value and negative predicted value.

  result <- data.frame()
  
  #Means
  Acc <- mean(ratings$TP + ratings$TN)/sum(ratings[1,])
  Sens <- mean(ratings$TP)/(ratings$TP[1] + ratings$FN[1])
  Spec <- mean(ratings$TN)/(ratings$TN[1] + ratings$FP[1])
  PPV <- mean(ratings$TP/(ratings$TP + ratings$FP))
  NPV <- mean(ratings$TN/(ratings$TN + ratings$FN))
  result <- rbind(result, data.frame(Acc, Sens, Spec, PPV, NPV))
  
  #Standard deviations
  Acc <- sd(ratings$TP + ratings$TN)/sum(ratings[1,])
  Sens <- sd(ratings$TP)/(ratings$TP[1] + ratings$FN[1])
  Spec <- sd(ratings$TN)/(ratings$TN[1] + ratings$FP[1])
  PPV <- sd(ratings$TP/(ratings$TP + ratings$FP))
  NPV <- sd(ratings$TN/(ratings$TN + ratings$FN))
  result <- rbind(result, data.frame(Acc, Sens, Spec, PPV, NPV))
  
  rownames(result) <- c("AV", "SD")
  return(result)
}