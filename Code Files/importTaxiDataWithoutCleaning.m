function taxiTable = importTaxiDataWithoutCleaning(filename)

% This code has been generated automatically using the Import Tool
opts = delimitedTextImportOptions("NumVariables", 19);

% Specify range and delimiter
opts.DataLines = [2 Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Vendor", "PickupTime", "DropoffTime", "Passengers", "Distance", "PickupLon", "PickupLat", "RateCode", "HeldFlag", "DropoffLon", "DropoffLat", "PayType", "Fare", "ExtraCharge", "Tax", "Tip", "Tolls", "ImpSurcharge", "TotalCharge"];
opts.VariableTypes = ["categorical", "datetime", "datetime", "double", "double", "double", "double", "categorical", "categorical", "double", "double", "categorical", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Vendor", "RateCode", "HeldFlag", "PayType"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "PickupTime", "InputFormat", "yyyy-MM-dd HH:mm:ss");
opts = setvaropts(opts, "DropoffTime", "InputFormat", "yyyy-MM-dd HH:mm:ss");

taxiTable = readtable(filename, opts);

codes = {'1','2','3','4','5','6'};

% Descriptive names corresponding to PayType codes 1-6.
payNames = {'Credit card','Cash','No charge','Dispute','Unknown','Voided'};

% Identify and rename the PayType codes that appear in taxiTable
payCodes = ismember(codes, categories(taxiTable.PayType));
taxiTable.PayType = renamecats(taxiTable.PayType, payNames(payCodes));

% Descriptive names corresponding to RateCats codes 1-6. 
% RateCodes not included in the "codes" list are not changed.
rateNames = {'Standard','JFK','Newark','Nassau','Negotiated','Group'}; 

% Identify and rename the RateCode codes that appear in taxiTable
rateCodes = ismember(codes, categories(taxiTable.RateCode));
taxiTable.RateCode = renamecats(taxiTable.RateCode, codes(rateCodes), rateNames(rateCodes));

end
