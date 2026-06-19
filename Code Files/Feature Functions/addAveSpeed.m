function taxiTable = addAveSpeed(taxiTable)
  if ~ismember('Duration', taxiTable.Properties.VariableNames)
      taxiTable = addDuration(taxiTable);
  end
  taxiTable.AveSpeed = taxiTable.Distance ./ taxiTable.Duration;
end
