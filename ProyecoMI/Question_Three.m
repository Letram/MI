function [] = Question_Three()
%QUESTION_THREE ¿Afectan los días/épocas festivos/as nacionales al número de vuelos y retrasos/cancelaciones en los aeropuertos?
    clear;
    
    ds = datastore({'airlines/1998.csv','airlines/1999.csv','airlines/2000.csv','airlines/2002.csv','airlines/2003.csv','airlines/2004.csv','airlines/2005.csv','airlines/2006.csv','airlines/2007.csv','airlines/2008.csv'},'TreatAsMissing', 'NA');
    ds.SelectedVariableNames = {'DayOfWeek', 'Month', 'Cancelled', 'DepDelay'};

    outds = mapreduce(ds, @holidayFlightsByDayMapper, @holidayFlightsByDayReducer);
    res = readall(outds);
    res = sortrows(res,1,'ascend');
    struct = table2struct(res);
    days = [];
    flights = [];
    delays = [];
    for i = 1:numel(struct)
        days = [days struct(i).Key];
        flights = [flights struct(i).Value(1)];
        delays = [delays struct(i).Value(2)];
    end
    
    subplot(2,1,1);
    bar(days, flights);
    subplot(2,1,2);
    bar(days, delays);
end

function holidayFlightsByDayMapper(data, ~, intermKVStore)
    delays = data.DepDelay; 
    day = data.DayOfWeek; 
    notNaN =~isnan(delays); 
    day = day(notNaN); 
    delays = delays(notNaN);  
    
    [intermKeys,~,idx] = unique(day, 'stable');
    intermVals = accumarray(idx,delays,size(intermKeys),@countsum);
    addmulti(intermKVStore,intermKeys,intermVals); 
end

function out = countsum(x)
    out = {[length(x) sum(x)]};
end

function holidayFlightsByDayReducer(intermKey, intermValIter, outKVStore)
    sum_occurences = 0;
    s = 0;
    while(hasnext(intermValIter))
        intermValue = getnext(intermValIter);
        sum_occurences = sum_occurences + intermValue(1);
        s = s + intermValue(2);
    end
    mean = s/sum_occurences;
    data = [sum_occurences mean];
    add(outKVStore, intermKey, data); 
end

