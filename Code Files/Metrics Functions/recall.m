function t = recall(ytrue,ypred)
  % Create the confusion matrix
  [CM,classnames] = confusionmat(ytrue,ypred);
  
  n = length(CM);
  Recall = zeros(n,1);
  % Calculate the precision for each class
  for k = 1:n
      % obtain by class counts of true positive and false negative classifications
      [TP,FN,~,~] = predictiveTotals(CM,k); 
      Recall(k) = TP/(TP+FN);
  end
  
  % Create output variable table t
  t = table(Recall,'RowNames',string(classnames));
end
