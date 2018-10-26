function [ output_args ] = Visualizador_img( input_args )
%VISUALIZADOR_IMG Summary of this function goes here
%   Detailed explanation goes here

load('cap1.mat');
%subplot(2,3,1);

figure(1);
captura1 = captura;
captura1_red = captura1(:,:,1);
captura1_green = captura1(:,:,2);
captura1_blue = captura1(:,:,3);
subplot(3,1,1);
title('R');
image(captura1_red);
subplot(3,1,2);
title('G');
image(captura1_green);
subplot(3,1,3);
title('B');
image(captura1_blue);


load('cap2.mat');
figure(2);
captura2 = captura;
captura2_red = captura2(:,:,1);
captura2_green = captura2(:,:,2);
captura2_blue = captura2(:,:,3);
subplot(3,1,1);
title('R');
image(captura2_red);
subplot(3,1,2);
title('G');
image(captura2_green);
subplot(3,1,3);
title('B');
image(captura2_blue);

load('cap3.mat');
%subplot(2,3,3);
captura3 = captura;
%imshow(captura3);

load('cap4.mat');
%subplot(2,3,4);
captura4 = captura;
%imshow(captura4);

load('cap5.mat');
%subplot(2,3,5);
captura5 = captura;
%imshow(captura5);

load('cap6.mat');
figure(6);
captura6 = captura;
captura6_red = captura6(:,:,1);
captura6_green = captura6(:,:,2);
captura6_blue = captura6(:,:,3);
subplot(3,1,1);
title('R');
image(captura6_red);
subplot(3,1,2);
title('G');
image(captura6_green);
subplot(3,1,3);
title('B');
image(captura6_blue);

figure(7);

%zona de interes: X[400,700], Y[200, 400]
%image(captura6(200:400, 400:700, :));
difference = captura2 - captura1;
difference = difference + (captura3 - captura2);
difference = difference + (captura4 - captura3);
difference = difference + (captura5 - captura4);
difference = difference + (captura6 - captura5);
difference = difference / 6;
image(difference(200:400, 400:700, :));

whos;


