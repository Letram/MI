%Escriba un fichero .m con las �rdenes necesarias para crear una gr�fica de
%sectores (en 3 dimensiones) de los datos estad�sticos anteriores y que
%contenga las leyendas de las comunidades aut�nomas.

values = [181,102,98,53,49,23,8,6];
states = ["Canarias", "Pais Vasco", "Madrid", "Catalu�a", "Asturias", "Extremadura", "Andaluc�a", "Otras"];
pie3(values, states)