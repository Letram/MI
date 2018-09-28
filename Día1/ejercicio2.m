function [ output_args ] = ejercicio2( input_args )
%EJERCICIO2 Summary of this function goes here
%   Detailed explanation goes here
clear;
    
    %Cargamos en numerosAleatorios el fichero.
    cmin = 0.25;
    cmax = 0.26;
    load 'numeros_aleatorios.mat';
    %Ejercicio1
    
    concatVect = []; 
    
    tic;
    
    for (i=1:size(randomMatrix,1))
        for j = 1: size(randomMatrix,2)
            if(randomMatrix(i,j) >= cmin && randomMatrix(i,j) <= cmax )
                disp(randomMatrix(i,j))
                concatVect = [concatVect randomMatrix(i,j)];
            end
        end
    end
    
    toc;
    
    disp(concatVect(1:10))
    %Ejercicio2
    
    clear('numeros_aleatorios');