# classification
Convenience layer for cross-validation in R

## Installation
1. Change the variable "folder" in install.r to where you put the functions folder of this toolbox.
2. Run the complete script install.r.

## Functions
### multi.crossvalidate
This is the main function that you will want to run on your data.frame.
In this data.frame, the true value is assumed to be in the last column, encoded in 0 (negative) and 1 (positive).
All values in the data.frame should be numerical. Convert characters and levels or remove them.

- Enter one of the predict.* to choose the classifier of your choice, do not add brackets.
- Load your data.frame and ensure it contains only numerical values, and the last column contains the true values.
- K is the number of folds, use 0 for leave-one-out.
- n.iter is the number of times to repeat K-fold cross-validation.

### rate.predictions 
Takes the result from multi.crossvalidate to determine the number of true and false positives and negatives.
Positive = 1 and negative = 0.

### interpret.ratings
In turn takes the result from rate.predictions to produce a classification summary.

### Wrappers
The predict.* functions are wrappers around classifier calls and are used to pass as an argument to 
multi.crossvalidate, to select the classifier to use for cross-validation.

## Example
`predictions <- multi.crossvalidate(predict.classifier = predict.naivebayes, data = your.data.frame, K = 10, n.iter = 10)`

`ratings <- rate.predictions(predictions)`

`summary <- interpret.ratings(ratings)`