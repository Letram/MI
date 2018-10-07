function [ output_args ] = Ejercicio1( input_args )
%EJERCICIO1 Summary of this function goes here
%   Detailed explanation goes here

paso = 0;
x = [];
% y = x^3 - x + 1; -3<=x<=3 (0.1)
figure(1);
paso = 0.1;
x = -3:paso:3;
y = x.^3-x+1;
plot(x, y)

% y = 1/(1+|x|^2); -5<=x<=5 (0.05)
figure(2);
paso = 0.05;
x = -5:paso:5;
y = 1./(1+abs(x).^2);
plot(x, y)

% y = x^2/x^2-1; -10<=x<=10 (0.01)
figure(3);
paso = 0.01;
x = -10:paso:10;
y = (x).^2./((x).^2-1);
plot(x, y);

% y = sen( e^x ); -pi <=x<=pi (0.01)
figure(4);
paso = 0.01;
x = -pi:paso:pi;
y = sin(exp(x));
plot(x,y)