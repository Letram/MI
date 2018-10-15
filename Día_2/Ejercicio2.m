%Escriba un fichero .m con las órdenes necesarias para crear una gráfica de
%sectores (en 3 dimensiones) de los datos estadísticos anteriores y que
%contenga las leyendas de las comunidades autónomas.

values = [181,102,98,53,49,23,8,6];
states = ["Canarias", "Pais Vasco", "Madrid", "Cataluña", "Asturias", "Extremadura", "Andalucía", "Otras"];
pie3(values, states)