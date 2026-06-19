% The following features were engineered based on the correlation heatmap and scatter plot outputs
entireTaxiDataCleaned.FarePerMile = entireTaxiDataCleaned.Fare ./ entireTaxiDataCleaned.Distance;
entireTaxiDataCleaned.FarePerMinute = entireTaxiDataCleaned.Fare ./ entireTaxiDataCleaned.Duration;

entireTaxiDataCleaned.DistanceXHour = entireTaxiDataCleaned.Distance .* entireTaxiDataCleaned.TimeOfDay;
entireTaxiDataCleaned.FareXDistance = entireTaxiDataCleaned.Fare .* entireTaxiDataCleaned.Distance;

entireTaxiDataCleaned.PickupHourBin = dateshift(entireTaxiDataCleaned.PickupTime, "start", "hour");
pickupGroup = groupsummary(entireTaxiDataCleaned, {'PickupRegion', 'PickupHourBin'}, ["mean"], ...
    ["Distance", "Duration", "Fare", "FarePerMile", "FarePerMinute", "DistanceXHour", "FareXDistance"]);
pickupGroup = renamevars(pickupGroup, ["PickupRegion","PickupHourBin","GroupCount"], ["Region", "HourlyBin","PickupCount"]);

entireTaxiDataCleaned.DropoffHourBin = dateshift(entireTaxiDataCleaned.DropoffTime, "start", "hour");
dropoffGroup = groupsummary(entireTaxiDataCleaned, {'DropoffRegion', 'DropoffHourBin'});
dropoffGroup = renamevars(dropoffGroup, ["DropoffRegion","DropoffHourBin","GroupCount"], ["Region","HourlyBin","DropoffCount"]);

groupedSummaryTable = innerjoin(pickupGroup, dropoffGroup, "Keys", ["Region", "HourlyBin"]);
groupedSummaryTable.NetPickups = groupedSummaryTable.PickupCount - groupedSummaryTable.DropoffCount;

x2015BankHolidays = addHolidays("Taxi Data/2015 Bank Holidays.csv");

isHoliday = ismember(dateshift(groupedSummaryTable.HourlyBin,'start','day'), x2015BankHolidays.Date);
groupedSummaryTable.IsHoliday = isHoliday;

% Response variable
groupedSummaryTable.Demand = categorical(discretize(groupedSummaryTable.NetPickups, [-Inf, 0, 15, Inf], 'categorical', ["Low", "Medium", "High"]));

clear entireTaxiDataCleaned dropoffGroup pickupGroup isHoliday x2015BankHolidays;
