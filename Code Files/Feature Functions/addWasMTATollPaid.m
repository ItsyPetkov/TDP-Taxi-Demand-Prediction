function taxiTable = addWasMTATollPaid(taxiTable)
  if ~ismember('TollSource', taxiTable.Properties.VariableNames)
      taxiTable = addTollSource(taxiTable);
  end
  taxiTable.WasMTATollPaid = taxiTable.TollSource;
  % Combine all MTA bridge and tunnel tolls into a single category
  taxiTable.WasMTATollPaid = mergecats(taxiTable.WasMTATollPaid,...
      {'CBGH','CBGH_cash','HH','HH_cash','MTA_other','MTA_other_cash','VN','VN_cash'},'MTA');
  % Create logical vector indicating trips charged and MTA toll
  taxiTable.WasMTATollPaid = taxiTable.WasMTATollPaid=='MTA';
end
