function [out] = countMember(data)
    values = unique(data);
    count = histc(data, values);
    out = count;
end
