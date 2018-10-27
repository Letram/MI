function [ output_args ] = Visualizador_img( input_args )
%VISUALIZADOR_IMG Summary of this function goes here
%   Detailed explanation goes here

load('cap1.mat');
differences_red = [];
differences_green = [];
differences_blue = [];

captura1 = captura;
captura1_red = captura1(:,:,1);
captura1_green = captura1(:,:,2);
captura1_blue = captura1(:,:,3);

differences_red = [differences_red mean(mean(captura1_red(200:400, 400:700)))];
differences_green = [differences_green mean(mean(captura1_green(200:400, 400:700)))];
differences_blue = [differences_blue mean(mean(captura1_blue(200:400, 400:700)))];

load('cap2.mat');
captura2 = captura;
captura2_red = captura2(:,:,1);
captura2_green = captura2(:,:,2);
captura2_blue = captura2(:,:,3);

differences_red = [differences_red mean(mean(captura2_red(200:400, 400:700)))];
differences_green = [differences_green mean(mean(captura2_green(200:400, 400:700)))];
differences_blue = [differences_blue mean(mean(captura2_blue(200:400, 400:700)))];

load('cap3.mat');
%subplot(2,3,3);
captura3 = captura;
captura3_red = captura3(:,:,1);
captura3_green = captura3(:,:,2);
captura3_blue = captura3(:,:,3);

differences_red = [differences_red mean(mean(captura3_red(200:400, 400:700)))];
differences_green = [differences_green mean(mean(captura3_green(200:400, 400:700)))];
differences_blue = [differences_blue mean(mean(captura3_blue(200:400, 400:700)))];

load('cap4.mat');
%subplot(2,3,4);
captura4 = captura;
captura4_red = captura4(:,:,1);
captura4_green = captura4(:,:,2);
captura4_blue = captura4(:,:,3);

differences_red = [differences_red mean(mean(captura4_red(200:400, 400:700)))];
differences_green = [differences_green mean(mean(captura4_green(200:400, 400:700)))];
differences_blue = [differences_blue mean(mean(captura4_blue(200:400, 400:700)))];

%imshow(captura4);

load('cap5.mat');
%subplot(2,3,5);
captura5 = captura;
captura5_red = captura5(:,:,1);
captura5_green = captura5(:,:,2);
captura5_blue = captura5(:,:,3);

differences_red = [differences_red mean(mean(captura5_red(200:400, 400:700)))];
differences_green = [differences_green mean(mean(captura5_green(200:400, 400:700)))];
differences_blue = [differences_blue mean(mean(captura5_blue(200:400, 400:700)))];

load('cap6.mat');
captura6 = captura;
captura6_red = captura6(:,:,1);
captura6_green = captura6(:,:,2);
captura6_blue = captura6(:,:,3);

differences_red = [differences_red mean(mean(captura6_red(200:400, 400:700)))];
differences_green = [differences_green mean(mean(captura6_green(200:400, 400:700)))];
differences_blue = [differences_blue mean(mean(captura6_blue(200:400, 400:700)))];

plot(differences_red, 'r');
hold on;
plot(differences_green, 'g');
plot(differences_blue, 'b');
hold off;

%zona de interes: X[400,700], Y[200, 400]
%image(captura6(200:400, 400:700, :));

whos;


