function t = rmse(ytrue,ypred)
  rmseValue = sqrt(mean((ytrue-ypred).^2,"omitnan"));
  t = table(rmseValue,'VariableNames',"rmse");
end
