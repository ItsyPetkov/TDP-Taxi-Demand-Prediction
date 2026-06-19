function t = Rsq(ytrue,ypred)
  yMean = mean(ytrue,"omitnan");
  SST = sum((ytrue-yMean).^2,"omitnan");
  SSE = sum((ytrue-ypred).^2,"omitnan");
  RsqValue = (SST-SSE)/SST;
  t = table(RsqValue,'VariableNames',"Rsq");
end
