function taxiTable = addTimeOfDay(taxiTable)
  taxiTable.TimeOfDay = hours(timeofday(taxiTable.PickupTime));
end
