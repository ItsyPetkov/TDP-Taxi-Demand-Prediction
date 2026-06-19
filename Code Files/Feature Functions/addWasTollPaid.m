function taxiTable = addWasTollPaid(taxiTable)
  taxiTable.WasTollPaid = taxiTable.Tolls > 0;
end
