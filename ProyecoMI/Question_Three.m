function [] = Question_Three()
%QUESTION_THREE ¿Afectan los días/épocas festivos/as nacionales al número de vuelos y retrasos/cancelaciones en los aeropuertos?
    clear;
    
    ds = datastore({'airlines/1998.csv','airlines/1999.csv','airlines/2000.csv','airlines/2002.csv','airlines/2003.csv','airlines/2004.csv','airlines/2005.csv','airlines/2006.csv','airlines/2007.csv','airlines/2008.csv'},'TreatAsMissing', 'NA');
    %ds = datastore('airlinesmall.csv', 'TreatAsMissing', 'NA');
    ds.SelectedVariableNames = {'DayOfWeek', 'Month', 'Cancelled', 'DepDelay'};

    outds = mapreduce(ds, @holidayFlightsByDayMapper, @holidayFlightsReducer);
    res = readall(outds);
    res = sortrows(res,1,'ascend');
    struct = table2struct(res);
    days = [];
    flights = [];
    delays = [];
    cancelations = [];
    for i = 1:numel(struct)
        days = [days struct(i).Key];
        flights = [flights struct(i).Value(1)];
        delays = [delays struct(i).Value(2)];
        cancelations = [cancelations struct(i).Value(3)];
    end
    flights = transpose(flights);
    cancelations = transpose(cancelations);
    combine = [flights cancelations];
    
    figure(1);
    subplot(2,1,1);
    bar(days, combine);
    title('Flights and cancelations by day of the week');
    xlabel('Day of the week');
    ylabel('Number of flights and cancelations');
    subplot(2,1,2);
    bar(days, delays);
    title('Average departure delay by day of the week');
    xlabel('Day of the week');
    ylabel('Average departure delay');
    
    outds = mapreduce(ds, @holidayFlightsByMonthMapper, @holidayFlightsReducer);
    res = readall(outds);
    res = sortrows(res,1,'ascend');
    struct = table2struct(res);
    days = [];
    flights = [];
    delays = [];
    cancelations = [];
    for i = 1:numel(struct)
        days = [days struct(i).Key];
        flights = [flights struct(i).Value(1)];
        delays = [delays struct(i).Value(2)];
        cancelations = [cancelations struct(i).Value(3)];
    end
    flights = transpose(flights);
    cancelations = transpose(cancelations);
    combine = [flights cancelations];
    
    figure(2);
    subplot(2,1,1);
    bar(days, combine);
    title('Flights and cancelations by month');
    xlabel('Month');
    ylabel('Number of flights and cancelations');
    subplot(2,1,2);
    bar(days, delays);
    title('Average departure delay by month');
    xlabel('Month');
    ylabel('Average departure delay');
end

function holidayFlightsByDayMapper(data, ~, intermKVStore)

    delays = data.DepDelay; 
    day = data.DayOfWeek; 
    
    notNaN =~isnan(delays);
    
    day = day(notNaN); 
    delays = delays(notNaN);  
    
    %in some files cancelations are nt counting because all data is missing
    cancelations = data.Cancelled;
    unparsedDays = data.DayOfWeek;
    
    [intermKeysDaysUnparsed,~,idxDaysUnparsed] = unique(unparsedDays, 'stable');
    [intermKeysDays,~,idxDays] = unique(day, 'stable');
    intermValsDays = accumarray(idxDays,delays,size(intermKeysDays),@countsum);
    intermValsCancelations = accumarray(idxDaysUnparsed, cancelations, size(intermKeysDaysUnparsed));
    aux = cell2mat(intermValsDays);
    aux = [aux intermValsCancelations];
    out = num2cell(aux,2);
    addmulti(intermKVStore,intermKeysDays,out); 
    
end

function holidayFlightsByMonthMapper(data, ~, intermKVStore)

    delays = data.DepDelay; 
    months = data.Month; 
    
    notNaN =~isnan(delays);
    
    months = months(notNaN); 
    delays = delays(notNaN);  
    
    %in some files cancelations are nt counting because all data is missing
    cancelations = data.Cancelled;
    unparsedMonth = data.Month;
    
    [intermKeysMonthUnparsed,~,idxMonthUnparsed] = unique(unparsedMonth, 'stable');
    [intermKeysMonth,~,idxMonth] = unique(months, 'stable');
    intermValsDays = accumarray(idxMonth,delays,size(intermKeysMonth),@countsum);
    intermValsCancelations = accumarray(idxMonthUnparsed, cancelations, size(intermKeysMonthUnparsed));
    aux = cell2mat(intermValsDays);
    aux = [aux intermValsCancelations];
    out = num2cell(aux,2);
    addmulti(intermKVStore,intermKeysMonth,out); 
    
end

function out = countsum(x)
    out = {[length(x) sum(x)]};
end

function holidayFlightsReducer(intermKey, intermValIter, outKVStore)
    sum_occurences = 0;
    s = 0;
    canc = 0;
    while(hasnext(intermValIter))
        intermValue = getnext(intermValIter);
        sum_occurences = sum_occurences + intermValue(1);
        s = s + intermValue(2);
        canc = canc + intermValue(3);
    end
    mean = s/sum_occurences;
    data = [sum_occurences mean canc];
    add(outKVStore, intermKey, data); 
end

