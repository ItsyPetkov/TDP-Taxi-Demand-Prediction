function t = specificity(ytrue,ypred)
  % Create the confusion matrix
  [CM,classnames] = confusionmat(ytrue,ypred);
  
  n = length(CM);
  Specificity = zeros(n,1);
  % Calculate the precision for each class
  for k = 1:n
      % obtain by class counts of false positive and True negative classifications
      [~,~,FP,TN] = predictiveTotals(CM,k); 
      Specificity(k) = TN/(TN+FP);
  end
  
  % Create output variable table t
  t = table(Specificity,'RowNames',string(classnames));
end
