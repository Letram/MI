function [] = Question_Two()
%QUESTION_TWO ¿Qué región o regiones de E.E.U.U. suelen tener más cancelaciones de vuelos por razones climatológicas? 
%             ¿Existe algún motivo para ello? 
    ds = datastore({'airlines/1998.csv','airlines/1999.csv','airlines/2000.csv','airlines/2001.csv','airlines/2002.csv','airlines/2003.csv','airlines/2004.csv','airlines/2005.csv','airlines/2006.csv','airlines/2007.csv','airlines/2008.csv'},'TreatAsMissing', 'NA');
    ds.SelectedVariableNames = {'CancellationCode', 'Cancelled', 'Origin'};
    ds.SelectedFormats{strcmp(ds.SelectedVariableNames, 'CancellationCode')} = '%s';
    ds.SelectedFormats{strcmp(ds.SelectedVariableNames, 'Origin')} = '%s';

    outds = mapreduce(ds, @weatherCancelMapper, @weatherCancelReducer);
    res = readall(outds)
end


function weatherCancelMapper (data, ~, intermKVStore)
    %Se estandarizan los NA por NaN
    data.CancellationCode = standardizeMissing(data.CancellationCode,'NA');
    % Se eliminan los NaN
    cleared = rmmissing(data);
    %pillar code y cancelled y crear un método que los compare elemento a
    %elemento, si code == b y cancelled == 1, entonces añado un 1 en un
    %vector que he creado. Si no, pues añado un 0.
    code = [cleared.CancellationCode];
    cancelled = [cleared.Cancelled];
    origins = [cleared.Origin];
    aux = ismember(code, 'B') & ismember(cancelled, 1);
    [intermKeys,~, idxs] = unique(origins, 'stable');
    intermVals = accumarray(idxs,aux,size(intermKeys),@countReason);
    addmulti(intermKVStore, intermKeys, num2cell(intermVals));
end

function weatherCancelReducer (intermKey, intermValIter, outKVStore)
    sum_occurences = 0;
    while(hasnext(intermValIter))
        sum_occurences = sum_occurences + getnext(intermValIter);
    end
    add(outKVStore, intermKey, sum_occurences); 
end

function out = countReason(cancelled)
    n = sum(cancelled == 1);
    out = n;
end