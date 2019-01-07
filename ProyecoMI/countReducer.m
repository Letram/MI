function countReducer(key, intermValIter, outKV)
    data = getnext(intermValIter);
    while hasnext(intermValIter)
        data = [data; getnext(intermValIter)];
    end
    add(outKV,key,data);
end