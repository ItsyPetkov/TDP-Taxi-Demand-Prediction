function taxiTable = addTaxiZones(taxiTable, shpfile)

  % If no shape file is specified, use the file provided in taxi data
  if nargin < 2
      shpfile = "TaxiZones.shp";
  end
  
  % Load the shape file data and convert to a table
  shapes = shaperead(shpfile, "UseGeoCoords",true);
  shapes = struct2table(shapes);
  
  % Convert variables to categoricals
  shapes.zone = categorical(shapes.zone);
  shapes.borough = categorical(shapes.borough);
  boroNames = categories(shapes.borough);
  zones = categories(shapes.zone);
  
  % Create feature variables as empty categorical arrays.
  % Define the possible categories using names obtained from the shapefile.
  taxiTable.tzPickupBorough = categorical(NaN(height(taxiTable),1),1:length(boroNames),boroNames);
  taxiTable.tzDropoffBorough = categorical(NaN(height(taxiTable),1),1:length(boroNames),boroNames);
  taxiTable.PickupZone = categorical(NaN(height(taxiTable),1),1:length(zones),zones);
  taxiTable.DropoffZone = categorical(NaN(height(taxiTable),1),1:length(zones),zones);
  
  for i = 1:height(shapes)
      
      % Identify trips with pick up locations in this zone
      pickupRows = inpolygon(taxiTable.PickupLon, taxiTable.PickupLat, shapes.Lon{i}, shapes.Lat{i});
      % Identify trips with drop off locations in this zone
      dropoffRows = inpolygon(taxiTable.DropoffLon, taxiTable.DropoffLat, shapes.Lon{i}, shapes.Lat{i});
      
      % Update taxi zone features with shape's zone name
      taxiTable.PickupZone(pickupRows) = shapes.zone(i);
      taxiTable.DropoffZone(dropoffRows) = shapes.zone(i);
      
      % Update borough features with shape's borough name
      taxiTable.tzPickupBorough(pickupRows) = shapes.borough(i);
      taxiTable.tzDropoffBorough(dropoffRows) = shapes.borough(i);
  end

end
