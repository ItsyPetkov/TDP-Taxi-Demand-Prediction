function taxiTable = addNeighborhood(taxiTable, shpfile)

  % If no shape file is specified, use the file provided in taxi data
  if nargin < 2
      shpfile = "NeighborhoodTabulationAreas.shp";
  end
  
  % Load the shape file data and convert to a table
  shapes = shaperead(shpfile, "UseGeoCoords",true);
  shapes = struct2table(shapes);
  
  % Convert variables to categoricals
  shapes.ntacode = categorical(shapes.ntacode);
  shapes.ntaname = categorical(shapes.ntaname);
  shapes.boro_name = categorical(shapes.boro_name);
  boroNames = categories(shapes.boro_name);
  ntaNames = categories(shapes.ntaname);
  
  % Create feature variables as empty categorical arrays.
  % Define the possible categories using names obtained from the shapefile.
  taxiTable.PickupBorough = categorical(NaN(height(taxiTable),1),1:length(boroNames),boroNames);
  taxiTable.DropoffBorough = categorical(NaN(height(taxiTable),1),1:length(boroNames),boroNames);
  taxiTable.PickupNeighborhood = categorical(NaN(height(taxiTable),1),1:length(ntaNames),ntaNames);
  taxiTable.DropoffNeighborhood = categorical(NaN(height(taxiTable),1),1:length(ntaNames),ntaNames);
  
  for i = 1:height(shapes)
      
      % Identify trips with pick up locations in this neighborhood
      pickupRows = inpolygon(taxiTable.PickupLon, taxiTable.PickupLat, shapes.Lon{i}, shapes.Lat{i});
      % Identify trips with drop off locations in this neighborhood
      dropoffRows = inpolygon(taxiTable.DropoffLon, taxiTable.DropoffLat, shapes.Lon{i}, shapes.Lat{i});
      
      % Update neighborhood features with shape's neighborhood name
      taxiTable.PickupNeighborhood(pickupRows) = shapes.ntaname(i);
      taxiTable.DropoffNeighborhood(dropoffRows) = shapes.ntaname(i);
      
      % Update borough features with shape's borough name
      taxiTable.PickupBorough(pickupRows) = shapes.boro_name(i);
      taxiTable.DropoffBorough(dropoffRows) = shapes.boro_name(i);
  end

end
