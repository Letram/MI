function [] = Question_One()
%QUESTION_ONE ¿Se vieron afectadas las salidas de los vuelos por razones de seguridad tras el atentado del 11S?
%r1 - En cuanto a la media de retrasos por años no se ha visto afectada,
%siendo ese año uno con un valor medianamente bajo en retrasos en
%comparación con los siguientes. No parece tener una gran repercusión en
%ese aspecto.
clear;
    ds = datastore('airlinesmall.csv', 'TreatAsMissing', 'NA');
    ds.SelectedVariableNames = {'DepDelay', 'Year'}; 
    outds = mapreduce(ds, @meanArrivalByYearMapper, @meanArrivalByYearReducer);
    res = readall(outds);
    res = sortrows(res,1,'ascend');
    bar(res.Key, table2array(varfun(@cell2mat, res(:,2))));
    title('Average departure delays from 1998 to 2008');
    xlabel('Year');
    ylabel('Average delay');
    set(gca,'XTick',res.Key)
end

 function meanArrivalByYearMapper (data, ~, intermKVStore)
     delays = data.DepDelay; 
     year = data.Year; 
     notNaN =~isnan(delays); 
     year = year(notNaN); 
     delays = delays(notNaN);  
     % find the unique days in this chunk 
     [intermKeys,~,idx] = unique(year, 'stable');  
     % group delays by idx and apply @grpstatsfun function to each group
     intermVals = accumarray(idx, delays, size(intermKeys), @countsum);
     %intermVals es una tupla [n, s] con el número de retrasos en ese
     %bloque de información como n y la suma de todos los valores de los
     %retrasos como s
     addmulti(intermKVStore,intermKeys,intermVals); 
 end
 function meanArrivalByYearReducer(intermKey, intermValIter, outKVStore) 
    n = 0;
    s = 0;  
    % get all sets of intermediate results 
    while hasnext(intermValIter)     
       intermValue = getnext(intermValIter);
       n = n + intermValue(1);  
       s = s + intermValue(2);
    end  
    mean = s/n; 
    add(outKVStore,intermKey,mean);  
 end
 
 function out = countsum(x) 
  n = length(x);
  s = sum(x);
  out = {[n, s]};  
end
