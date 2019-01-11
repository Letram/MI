function [] = Question_One()
%QUESTION_ONE ¿Se vieron afectadas las salidas de los vuelos por razones de seguridad tras el atentado del 11S?
%r1 - En cuanto a la media de retrasos por años no se ha visto afectada,
%siendo ese año uno con un valor medianamente bajo en retrasos en
%comparación con los siguientes. No parece tener una gran repercusión en
%ese aspecto.
    clear;
    ds = datastore('airlines/2001.csv', 'TreatAsMissing', 'NA');
    ds.SelectedVariableNames = {'Cancelled', 'Month'};
    outds = mapreduce(ds, @meanArrivalByMonthMapper, @meanArrivalByMonthReducer);
    res = readall(outds);
    res = sortrows(res,1,'ascend');
    figure(1);
    bar(res.Key, table2array(varfun(@cell2mat, res(:,2))));
    title('Cancelations per month of 2001');
    xlabel('Month');
    ylabel('Cancelations');
    set(gca,'XTick',res.Key);

%     ds = datastore('airlines/2001.csv', 'TreatAsMissing', 'NA');
%     ds.SelectedVariableNames = {'Cancelled', 'Month', 'DayofMonth'};
%     outds = mapreduce(ds, @meanArrivalByDayMapper, @meanArrivalByDayReducer);
%     res = readall(outds);
%     res = sortrows(res,1,'ascend');
%     figure(2);
%     bar(res.Key, table2array(varfun(@cell2mat, res(:,2))));
%     title('Cancelations per month of 2001');
%     xlabel('Month');
%     ylabel('Cancelations');
%     set(gca,'XTick',res.Key);
end

 function meanArrivalByMonthMapper (data, ~, intermKVStore)
     cancelations = data.Cancelled; 
     month = data.Month; 
     notNaN =~isnan(cancelations); 
     month = month(notNaN); 
     cancelations = cancelations(notNaN);  
     % find the unique days in this chunk 
     [intermKeys,~,idx] = unique(month, 'stable');  
     % group delays by idx and apply @grpstatsfun function to each group
     intermVals = accumarray(idx, cancelations, size(intermKeys), @countsum);
     %intermVals es una tupla [n, s] con el número de retrasos en ese
     %bloque de información como n y la suma de todos los valores de los
     %retrasos como s
     addmulti(intermKVStore,intermKeys,intermVals); 
 end
 function meanArrivalByMonthReducer(intermKey, intermValIter, outKVStore) 
    s = 0;  
    % get all sets of intermediate results 
    while hasnext(intermValIter)     
       intermValue = getnext(intermValIter);
       s = s + intermValue(1);
    end  
    add(outKVStore,intermKey,s);  
 end
 
 function out = countsum(x) 
  s = sum(x);
  out = {s};  
 end

%   function meanArrivalByDayMapper (data, ~, intermKVStore)
%      cancelations = data.Cancelled;
%      month = data.Month; 
%      dom = data.DayofMonth;
%      notNaN =~isnan(cancelations); 
%      month = month(notNaN); 
%      dom = dom(notNan);
%      cancelations = cancelations(notNaN);  
%      september = ismember(month, 9);
%      domSep = auxCustom(dom, september, cancelations);
%      % find the unique days in this chunk 
%      [intermDays,~,daysIndex] = unique(domSep, 'stable');  
%      % group delays by idx and apply @grpstatsfun function to each group
%      intermVals = accumarray(daysIndex, cancelations, size(intermDays), @countsum);
%      %intermVals es una tupla [n, s] con el número de retrasos en ese
%      %bloque de información como n y la suma de todos los valores de los
%      %retrasos como s
%      addmulti(intermKVStore,intermKeys,intermVals); 
%  end
%  function meanArrivalByDayReducer(intermKey, intermValIter, outKVStore) 
%     s = 0;  
%     % get all sets of intermediate results 
%     while hasnext(intermValIter)     
%        intermValue = getnext(intermValIter);
%        s = s + intermValue(1);
%     end  
%     add(outKVStore,intermKey,s);  
%  end
%  
%  function out = auxCustom (dow, september)
%     res = [];
%     for i = 1 : length(dow)
%         if(september(i) == 1 && cancelled(i) == 1)
%             res = [res dow(i)];
%         end
%     end
%     out = res;
%  end
