function partidosprediction = importfile(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  PARTIDOSPREDICTION = IMPORTFILE(FILE) reads data from the first
%  worksheet in the Microsoft Excel spreadsheet file named FILE.
%  Returns the data as a table.
%
%  PARTIDOSPREDICTION = IMPORTFILE(FILE, SHEET) reads from the specified
%  worksheet.
%
%  PARTIDOSPREDICTION = IMPORTFILE(FILE, SHEET, DATALINES) reads from
%  the specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  partidosprediction = importfile("C:\Users\jorge\Desktop\prediccion\partidos_prediction.xlsx", "Hoja1", [2, 6]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 16-May-2021 12:43:09

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 6];
end

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 2);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":B" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["Equipo1", "Equipo2"];
opts.VariableTypes = ["string", "string"];

% Specify variable properties
opts = setvaropts(opts, ["Equipo1", "Equipo2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Equipo1", "Equipo2"], "EmptyFieldRule", "auto");

% Import the data
partidosprediction = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":B" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    partidosprediction = [partidosprediction; tb]; %#ok<AGROW>
end

end