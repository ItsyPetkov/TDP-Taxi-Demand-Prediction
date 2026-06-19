function taxiTable = filterTollTrips(taxiTable)

  % Filter table
  taxiTable = taxiTable(taxiTable.TollSource ~= "NoToll", :);
  
  % Merge similar toll categories 
  taxiTable.TollSource = mergecats(taxiTable.TollSource, ["HH","HH_MTA_Other"], "HH");
  taxiTable.TollSource = mergecats(taxiTable.TollSource, ["VN","VN_MTA_Other"], "VN");
  taxiTable.TollSource = mergecats(taxiTable.TollSource, ["CBGH","CBGH_MTA_Other"], "CBGH");
  taxiTable.TollSource = mergecats(taxiTable.TollSource, ["NYPA","NYPA_MTA_Other"], "NYPA");
  
  % Rename MTA_Other and OtherToll classes.
  taxiTable.TollSource = renamecats(taxiTable.TollSource, ["MTA_Other","OtherToll"], ["MTA","Other"]);
  
  % Remove empty categories
  taxiTable.TollSource = removecats(taxiTable.TollSource);

end
