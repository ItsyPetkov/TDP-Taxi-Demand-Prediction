function t = fallout(ytrue,ypred)
  % Create the confusion matrix
  [CM,classnames] = confusionmat(ytrue,ypred);
  
  n = length(CM);
  Fallout = zeros(n,1);
  % Calculate the precision for each class
  for k = 1:n
      % obtain by class counts of false positive and true negative classifications
      [~,~,FP,TN] = predictiveTotals(CM,k); 
      Fallout(k) = FP/(FP+TN);
  end
  
  % Create output variable table t
  t = table(Fallout,'RowNames',string(classnames));
end
