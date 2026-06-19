function taxiTable = addCrowDirection(taxiTable)
  % Compute the trip azimuth
  [~,az] = distance(taxiTable.PickupLat, taxiTable.PickupLon, taxiTable.DropoffLat, taxiTable.DropoffLon);
  taxiTable.CrowDirection = az;
end
