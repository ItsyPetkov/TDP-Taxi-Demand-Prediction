function taxiTable = importTaxiData(filename)
  taxiTable = importTaxiDataWithoutCleaning(filename);
  taxiTable = basicPreprocessing(taxiTable);
end
