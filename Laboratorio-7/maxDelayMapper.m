function maxDelayMapper(data, ~, intermKVStore)
%MAXDELAYMAPPER Summary of this function goes here
%   Detailed explanation goes here
maxDelayedTime = max(data{:,:});
add(intermKVStore, 'MaxDelayedTime',maxDelayedTime);
end

