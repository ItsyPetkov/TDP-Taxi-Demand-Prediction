function t = mae(ytrue,ypred)
  maeValue = mean(abs(ytrue-ypred),"omitnan");
  t = table(maeValue,'VariableNames',"mae");
end
