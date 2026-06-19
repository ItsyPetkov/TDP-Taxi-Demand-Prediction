function taxiTable = addDayOfWeek(taxiTable)
  % Get weekday in string format
  [~,taxiTable.DayOfWeek] = weekday(taxiTable.PickupTime,"long");
  
  % Convert to categorical array
  taxiTable.DayOfWeek = categorical(cellstr(taxiTable.DayOfWeek));
end
