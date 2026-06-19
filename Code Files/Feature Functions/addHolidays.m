function x2015BankHolidays = addHolidays(filename, dataLines)

  % If dataLines is not specified, define defaults
  if nargin < 2
      dataLines = [2, Inf];
  end
  
  opts = delimitedTextImportOptions("NumVariables", 2, "Encoding", "UTF-8");
  
  % Specify range and delimiter
  opts.DataLines = dataLines;
  opts.Delimiter = ",";
  
  % Specify column names and types
  opts.VariableNames = ["Date", "Holiday"];
  opts.VariableTypes = ["datetime", "string"];
  
  % Specify file level properties
  opts.ExtraColumnsRule = "ignore";
  opts.EmptyLineRule = "read";
  
  % Specify variable properties
  opts = setvaropts(opts, "Holiday", "WhitespaceRule", "preserve");
  opts = setvaropts(opts, "Holiday", "EmptyFieldRule", "auto");
  opts = setvaropts(opts, "Date", "InputFormat", "MM/dd/yyyy", "DatetimeFormat", "preserveinput");
  
  % Import the data
  x2015BankHolidays = readtimetable(filename, opts, "RowTimes", "Date");

end
