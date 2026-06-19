function t = f1(ytrue,ypred)
  % Obtain class-wise precision and recall values
  p = precision(ytrue,ypred);
  r = recall(ytrue,ypred);
  
  % Compute F1 score for each class using elementwise operators
  F1 = 2*(p.Precision.*r.Recall)./(p.Precision+r.Recall);
  
  % Create output variable table t
  t = table(F1,'RowNames',p.Properties.RowNames);
end
