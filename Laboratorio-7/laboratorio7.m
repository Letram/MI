clear;
filename = 'lineas.xlsx';
%Maximum delayed time of the file.
field = 'O:O';
delayTimes = xlsread(filename, field);

[maxDelay, index] = max(delayTimes);

disp(maxDelay);

%Data of the most delayed flight


