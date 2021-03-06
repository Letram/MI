function [ output_args ] = ejercicio3( input_args )

clear;
    
    %Cargamos en numerosAleatorios el fichero.
    load 'numeros_aleatorios.mat';
    %Ejercicio3
    intervals = [0 0.3 0.5 0.6 0.7 0.9 1];
    centers = [0.15, 0.4 0.55 0.65 0.8 0.95]
    res = [];
    tic;
    
    for(i = 1: size(intervals,2)-1)
        res = [res size(find(randomMatrix >= intervals(i) & randomMatrix < intervals(i+1)), 1)];
    end
    %histogram(randomMatrix, intervals)
    
    toc;
    bar(res)
    %clear('numeros_aleatorios');