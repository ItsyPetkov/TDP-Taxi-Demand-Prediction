function [t,a] = cMetrics(ytrue,ypred)
  % create a table where each variable is the output of a metric function 
  t = [precision(ytrue,ypred), ...
       recall(ytrue,ypred), ...
       fallout(ytrue,ypred), ...
       specificity(ytrue,ypred), ...
       f1(ytrue,ypred)];
  
  % Compute accuracy and write the percentage to the screen
  a = accuracy(ytrue,ypred);
  fprintf('Accuracy = %0.2f%%',a*100);
  
  % Compute average of each metric across all classes
  avg = mean(t{:,:},1);
  
  % Categories are in alphabetical order by default
  % Place ytrue classes in the same order as rows in t
  ytrue = reordercats(categorical(ytrue),t.Properties.RowNames);
  
  % Count the number of occurrences of each class
  wt = countcats(ytrue);
  
  % Compute weighted average of each metric across all classes
  % eqn: wtavg = sum(metric(i) * wt(i) / total number of labels)
  wtavg = sum(t{:,:}.*wt/sum(wt),1);
  tavg = array2table([avg;wtavg], ...
      "VariableNames",["Precision","Recall","Fallout","Specificity","F1"],...
      "RowNames",["Avg","WgtAvg"]);
  
  % Add table tavg to the bottom of table t
  t = [t;tavg];    
end
