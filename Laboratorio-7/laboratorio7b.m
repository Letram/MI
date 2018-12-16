clear;
filename = 'lineas.xlsx';
desiredColumn = 15;
desiredColumnStr = "ArrDelay";
flights = xlsread('lineas.xlsx');
%Maximum delayed time of the file and index.
tic;
[data, index] = max(flights(:, desiredColumn));
disp(data);
%Data of the most delayed flight
disp(flights(index,:));
toc;
clear;
