function [ output_args ] = ejercicio2bis( input_args )
%EJERCICIO2 Summary of this function goes here
%   Detailed explanation goes here
clear;
    
    %Cargamos en numerosAleatorios el fichero.
    cmin = 0.25;
    cmax = 0.26;
    load 'numeros_aleatorios.mat';
    %Ejercicio2bis
    
    tic;
    values = find(randomMatrix >= cmin & randomMatrix <= cmax);
    toc;
    
    whos
    disp(randomMatrix(values(1:10)))
    %Ejercicio2
    
    clear('numeros_aleatorios');