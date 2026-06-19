function taxiTable = addDuration(taxiTable)
  taxiTable.Duration = minutes(taxiTable.DropoffTime - taxiTable.PickupTime); 
end
