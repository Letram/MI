function [ output_args ] = Ejemplos_3d( input_args )
%EJEMPLOS_3D Summary of this function goes here
%   Detailed explanation goes here


%esfera
clear all;
clc;
subplot(2,2,1);
title('Esfera');
R = 1;
Nt = 20;
Np = 40;
theta = linspace(0,pi,Nt);
phi = linspace(0,pi*2,Np);
[Theta,Phi] = meshgrid(theta,phi);
X = R .* sin(Theta) .* cos(Phi);
Y = R .* sin(Theta) .* sin(Phi);
Z = R .* cos(Theta);

surf(X,Y,Z);
axis equal;
axis off;
cameratoolbar;

%toro
subplot(2,2,2);
title('Toro');
R1 = 3;
R2 = 1;
Nt = 20;
Np = 50;
theta = linspace(0,2*pi,Nt);
phi = linspace(0,2*pi,Np);
[Theta,Phi] = meshgrid(theta,phi);
X = (R1+R2 .* cos(Theta)) .* cos(Phi);
Y = (R1+R2 .* cos(Theta)) .* sin(Phi);
Z = R2 .* sin(Theta);
surf(X,Y,Z);
axis equal;
axis off;

%mesh de 10 valores aleatorios
rand1 = subplot(2,2,3);
title('Random 10');
x = rand(10);
colorMap = [linspace(0,1,256)', zeros(256,2)];
colormap(rand1, colorMap);
mesh(x);

%mesh de 100 valores aleatorios
rand2 = subplot(2,2,4);
title('Random 100');
x = rand(100);
colorMap = [linspace(0,1,256)', zeros(256,2)];
colormap(rand2, default);
mesh(x);