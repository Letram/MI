%Haciendo uso de un fichero o programa .m y utilizando el comando surf,
%dibuje la función tridimensional z = e^-(x^2+y^2)*cos(3*(x^2+y^2))
%en el intervalo -2 +2 y un paso de 0.1 (tanto para x como para y)

paso = 0.1;
[x,y] = meshgrid(-2:paso:2);
z = exp(-(x.^2 + y.^2)) .* cos(3.*(x.^2 + y.^2));

surf(x,y,z);