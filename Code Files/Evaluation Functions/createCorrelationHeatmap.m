function fig = createCorrelationHeatmap(T)

  Tnum = T(:, vartype('numeric'));
  
  % Remove constant columns
  isConstant = varfun(@(x) numel(unique(x(~isnan(x)))) <= 1, Tnum, ...
      'OutputFormat','uniform');
  
  Tnum(:, isConstant) = [];
  
  X = table2array(Tnum);
  R = corr(X, 'Rows','complete');
  
  fig = figure;
  
  heatmap(Tnum.Properties.VariableNames, ...
      Tnum.Properties.VariableNames, ...
      R, ...
      'Colormap', turbo, ...
      'ColorLimits', [-1 1]);
  
  title('Correlation Heatmap');

end
