function [ output_args ] = Ejercicio1( input_args )
%EJERCICIO1 Summary of this function goes here
%   Detailed explanation goes here

paso = 0.1;
%y = sqrt(x^2-1) [-3.3, -1,3]

x = -3.3:0.1:-1.3;
y = sqrt(x.^2-1);
figure(1);
plot(x,y);

%y = x^2 * sin(1/x) [-2,2]

x = -2:0.1:2;
y = x.^2 .* sin(1./x);
figure(2);
plot(x,y);

paso = 0.001;
%y = x^2*sin(1/x) [-0.1, 0.1]
x = -0.1:paso:0.1;
y = x.^2 .* sin(1./x);
figure(3);
plot(x,y);