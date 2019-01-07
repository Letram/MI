function [out] = getKeys(data)
    y = [];
    for i = 1:length(data)
        if(ismember(data(i), y) == 1)
            %Number is present in the array
        else
            %Number is not present in the array
            y = [y data(i)];
        end
    end
    out = y;
end

