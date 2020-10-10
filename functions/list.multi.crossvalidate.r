list.multi.crossvalidate <- function(predict.classifier, data.list, K = 10, n.iter = 10, varargin = NULL)
{
res <- list()

for (i in 1:length(data.list)) {
  res[[i]] <- multi.crossvalidate(predict.classifier, data.list[[i]], K, n.iter, varargin)
}

return(res)
}