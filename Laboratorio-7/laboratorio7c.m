clear; 

flights = datastore('airlinesmall.csv', 'TreatAsMissing', 'NA');
flights.SelectedFormats{strcmp(flights.SelectedVariableNames, 'TailNum')} = '%s';
flights.SelectedFormats{strcmp(flights.SelectedVariableNames, 'CancellationCode')} = '%s';

subset = [];

while(hasdata(flights))
    t = read(flights);
    t = t(strcmp(t.UniqueCarrier, 'UA') & strcmp(t.Origin, 'BOS'), :);
    subset = vertcat(subset, t);
end

reset(flights);
flights.SelectedVariableNames = {"ArrDelay"};
result = mapreduce(flights, @maxDelayMapper, @maxDelayReducer);
readall(result)
