function a = accuracy(ytrue,ypred)
  % Create the confusion matrix
  CM = confusionmat(ytrue,ypred); 
  
  % Correctly identified
  sumCorrect = sum(diag(CM)); 
  % Total number of observations
  sumAll = sum(CM,'all');
  
  % Compute accuracy
  a = sumCorrect/sumAll;   
end
