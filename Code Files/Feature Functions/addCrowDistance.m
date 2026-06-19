function taxiTable = addCrowDistance(taxiTable)
  arclen = distance(taxiTable.PickupLat, taxiTable.PickupLon, taxiTable.DropoffLat, taxiTable.DropoffLon);
  taxiTable.CrowDistance = deg2sm(arclen);
end
