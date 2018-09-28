function [ output_args ] = ejercicio1( input_args )
    clear;
    
    %Cargamos en numerosAleatorios el fichero.
    
    load 'numeros_aleatorios.mat';
    %Ejercicio1
    
    tic;
    
        maxValues = max(randomMatrix');
        minValues = min(randomMatrix');
    
    toc;
    
    disp(maxValues(1:10));
    disp(minValues(1:10));
    
    %Ejercicio2
    
    clear('numeros_aleatorios');
end