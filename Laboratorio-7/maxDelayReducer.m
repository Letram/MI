function maxDelayReducer(~, intermValsIter,outKVStore)
    maxDelayedTime = -inf;
    while hasnext(intermValsIter)
        maxDelayedTime = max(maxDelayedTime, getnext(intermValsIter));
    end
    add(outKVStore, 'MaxDelayedTime', maxDelayedTime);
end

