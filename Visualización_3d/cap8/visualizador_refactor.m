%For this exercise we create a structure with 3 parameters (r,g,b) called
%"cap" in which we are storing each layer of color (r,g,b) of each picture.
for i = 1:6
    filename = ['cap' int2str(i)];
    load(filename, 'captura');
    cap(i).r = captura(:,:,1);
    cap(i).g = captura(:,:,2);
    cap(i).b = captura(:,:,3);
end

%We then need to create a vector used to store the mean value of each layer
%of colour of each picture and then plot it so we can see how the
%concentration of each colour evolves.
differences_red = [];
differences_green = [];
differences_blue = [];

for i = 1:6
    differences_red = [differences_red mean(mean(cap(i).r(200:400, 400:700)))];
    differences_green = [differences_green mean(mean(cap(i).g(200:400, 400:700)))];
    differences_blue = [differences_blue mean(mean(cap(i).b(200:400, 400:700)))];
end

plot(differences_red, 'r');
hold on;
plot(differences_green, 'g');
plot(differences_blue, 'b');
hold off;

whos;
