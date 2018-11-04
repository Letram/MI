function [ output_args ] = EjercicioPropuesto( input_args )
%EJERCICIOPROPUESTO Summary of this function goes here
%   Detailed explanation goes here
    clear;
    intervals = 0:1000:10000
    getDiagonalMatrix = @(diagLength, minValue, maxValue) diag(minValue + (maxValue - minValue) .* rand(diagLength, 1));

    matrix = getDiagonalMatrix(100, 0, 100);
    newMatrix = getSquaredSparseMatrix(matrix);

    function [SMatrix] = getSquaredSparseMatrix(matrix)
        ResMatrix = sparse(matrix);
        ResMatrix = Square(ResMatrix);
        function[SquaredMatrix] = Square(SparseMatrix)
            SquaredMatrix = SparseMatrix .^ 2;
        end
        SMatrix = ResMatrix;
    end
    %newMatrix = full(newMatrix);
    %histogram(newMatrix, intervals);
    bar(adaptToBarPlot(intervals, newMatrix));
    whos;
end

function [res] = adaptToBarPlot(intervals, matrix)
    res = [];
    
    for(i = 1: size(intervals,2)-1)
        res = [res size(find(matrix >= intervals(i) & matrix < intervals(i+1)), 1)];
    end
    %histogram(randomMatrix, intervals)
end