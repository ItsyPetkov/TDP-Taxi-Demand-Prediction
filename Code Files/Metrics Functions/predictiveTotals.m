function [TP,FN,FP,TN] = predictiveTotals(CM,k)
  % in a confusion matrix, rows represent the true class, and columns represent the predicted class
  % Entries along the diagonal (row==column) indicate the number of observations 
  % whose label was correctly predicted.
  TP = CM(k,k);                   % True positive
  
  % Row k means observations that are actually class k
  FN = sum(CM(k,:))-TP;           % False negative
  
  % Column k means observations that were predicted to be class k
  FP = sum(CM(:,k))-TP;           % False positive
  
  TN = sum(CM,'all')-TP-FN-FP;    % True negative
        
end
