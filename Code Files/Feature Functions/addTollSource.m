function taxiTable = addTollSource(taxiTable)

  taxiTable.TollSource = taxiTable.Tolls;
  
  % Names of the various toll sources to classify
  sources = {'NoToll','CBGH','HH','VN','MTA_Other','CBGH_MTA_Other','HH_MTA_Other','VN_MTA_Other','NYPA','NYPA_MTA_Other','OtherToll'};
  
  % Corresponding rate that will be used to identify each source. 
  % The EZ-pass off-peak rate valid on Jan 1, 2015 is used.
  tolls = [0,2,2.44,10.66,5.33,7.33,7.77,15.99,9.75,15.08];
  
  % Use latitude to determine source of $7.50/$8 tolls 
  % If pick up and drop off locations are North of CBGH, assign MTA_Other rate
  taxiTable.TollSource(ismember(taxiTable.TollSource,[7.50,8]) & ...
      taxiTable.PickupLat > 40.617 & taxiTable.DropoffLat > 40.617) = 5.33; % 40°37'N
  
  % Use longitude to determine source of $10.66/$15/$11.08/$16 tolls 
  % If pick up and drop off locations are East of VN, assign MTA_Other rate
  taxiTable.TollSource(ismember(taxiTable.TollSource,[10.66,15,11.08,16]) & ...
      taxiTable.PickupLon > -74.05 & taxiTable.DropoffLon > -74.05) = 5.33; % 74°03'W
  
  % List all known toll charges for each source
  tollconversions = {{2,[4,3.75,7.50,2.08,4.16,8.00]},...         % 'CBGH'
                     {2.44,[4.88,5,10,2.54,5.08,5.50,11]},...     % 'HH'
                     {10.66,[15,11.08,16]},...                    % 'VN'
                     {5.33,5.54},...                              % 'MTA_Other'
                     {7.33,7.62},...                              % 'CBGH_MTA_Other'
                     {7.77,8.08},...                              % 'HH_MTA_Other'
                     {15.99,16.62},...                            % 'VN_MTA_Other'
                     {9.75,[11.75,10.50,12.50]}, ...              % 'NYPA'
                     {15.08,[17.08,16.04,18.04,15.29,17.29]}};    % 'NYPA_MTA_Other'
  
  % For each source, convert charges to the right of the comma into the value to the left.
  for i = 1:length(tollconversions)
      taxiTable.TollSource(ismember(taxiTable.TollSource,tollconversions{i}{2})) = tollconversions{i}{1};
  end    
  
  % Change all unknown toll charges to NaN.
  taxiTable.TollSource(~ismember(taxiTable.TollSource,tolls)) = NaN;  % 'OtherToll'
  
  taxiTable.TollSource = categorical(taxiTable.TollSource,[tolls,NaN],sources);

end
