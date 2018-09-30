function [ output_args ] = ejercicio3( input_args )

clear;
    
    %Cargamos en numerosAleatorios el fichero.
    load 'numeros_aleatorios.mat';
    %Ejercicio3
    intervals = [0 0.3 0.5 0.6 0.7 0.9 1];
    tic;

    histogram(randomMatrix, intervals)
    
    toc;
    
    clear('numeros_aleatorios');