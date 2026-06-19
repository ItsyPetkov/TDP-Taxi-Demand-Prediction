function taxiTable = basicPreprocessing(taxiTable)
    
    % The following code was captured using Live Editor tools
    taxiTable = taxiTable(taxiTable.Passengers > 0, :);   % At least 1 passenger
    taxiTable = taxiTable(taxiTable.Distance > 0 , :);  %Valid trip distance
    
    % The following code was captured using Live Editor tools
    taxiTable = taxiTable(taxiTable.RateCode ~= "99", :);   % Valid rate code
    taxiTable = taxiTable(taxiTable.Fare > 0, :);           % Valid fare
    taxiTable = taxiTable(taxiTable.ExtraCharge >= 0, :);   % Positive charge
    taxiTable = taxiTable(taxiTable.Tax > 0, :);            % Valid tax
    taxiTable = taxiTable(taxiTable.Tip >= 0, :);           % Positive tip
    taxiTable = taxiTable(taxiTable.Tolls >= 0, :);         % Positive toll
    taxiTable = taxiTable(taxiTable.ImpSurcharge >= 0, :);  % Positive charge
    taxiTable = taxiTable(taxiTable.TotalCharge > 0, :);    % Valid total
    
    taxiTable = taxiTable(abs(taxiTable.ImpSurcharge-0.3) < 0.01, :); 
    taxiTable = taxiTable(abs(taxiTable.Tax-0.5) < 0.01, :); 
    taxiTable = taxiTable(abs(taxiTable.Fare + taxiTable.ExtraCharge + ...
        taxiTable.Tax + taxiTable.Tip + taxiTable.Tolls + taxiTable.ImpSurcharge - ...
        taxiTable.TotalCharge) < 0.01, :);
    
    % Remove invalid Lon and Lat locations
    taxiTable = standardizeMissing(taxiTable, 0, "DataVariables", ["PickupLat","PickupLon","DropoffLat","DropoffLon"]);
    taxiTable = rmmissing(taxiTable, "DataVariables", ["PickupLat","PickupLon","DropoffLat","DropoffLon"]);
    
    % New features added
    taxiTable = addDuration(taxiTable); 
    taxiTable = addAveSpeed(taxiTable);
    taxiTable = addTimeOfDay(taxiTable);
    taxiTable = addDayOfWeek(taxiTable);
    
    % Bounding latitude/longitude
    lat = [40.5612 40.9637]; 
    lon = [-74.1923 -73.5982]; 
    
    % Identify pickup and drop off locations inside the region of interest
    inROI = inpolygon(taxiTable.PickupLat,taxiTable.PickupLon, lat([1 2 2 1]),lon([1 1 2 2])) ...
        & inpolygon(taxiTable.DropoffLat,taxiTable.DropoffLon, lat([1 2 2 1]),lon([1 1 2 2]));
    
    % Only keep trips that begin and end inside the region of interest.
    taxiTable = taxiTable(inROI,:);
    
    % Typical trip
    taxiTable = taxiTable(taxiTable.Duration >= 1 & taxiTable.Duration <= 120, :);      % minutes
    taxiTable = taxiTable(taxiTable.AveSpeed >= 0.1 & taxiTable.AveSpeed <= 100, :);    % mph
    taxiTable = taxiTable(taxiTable.Distance >= 0.01 & taxiTable.Distance <= 400, :);    % miles
    
    % Typical charges
    taxiTable = taxiTable(taxiTable.Fare >= 2.50 & taxiTable.Fare <= 140, :);
    taxiTable = taxiTable(taxiTable.ExtraCharge >= 0 & taxiTable.ExtraCharge < 3, :);
    taxiTable = taxiTable(taxiTable.Tip >= 0 & taxiTable.Tip <=145, :);
    taxiTable = taxiTable(taxiTable.Tax >= 0 & taxiTable.Tax < 5, :);
    taxiTable = taxiTable(taxiTable.Tolls <= 20, :);
    taxiTable = taxiTable(taxiTable.TotalCharge >= 0.5 & taxiTable.TotalCharge < 175, :);
end
