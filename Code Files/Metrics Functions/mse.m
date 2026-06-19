function t = mse(ytrue,ypred)
  mseValue = mean((ytrue-ypred).^2,"omitnan");
  t = table(mseValue,'VariableNames',"mse"); 
end
