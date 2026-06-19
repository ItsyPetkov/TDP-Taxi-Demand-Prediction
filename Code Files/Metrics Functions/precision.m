function t = precision(ytrue,ypred)
  % Create the confusion matrix
  [CM,classnames] = confusionmat(ytrue,ypred);
  
  n = length(CM);
  Precision = zeros(n,1);
  % Calculate the precision for each class
  for k = 1:n
      % obtain by class counts of true positive and false positive classifications
      [TP,~,FP,~] = predictiveTotals(CM,k);
      Precision(k) = TP/(TP+FP);
  end
  
  % Create output variable table t
  t = table(Precision,'RowNames',string(classnames));
end
