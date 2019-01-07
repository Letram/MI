%Utilizando los datos relativos a los vuelos comerciales realizados entre los años 1.998 y 2.008, buscar respuesta y argumentación a las siguientes preguntas:
%1.- ¿Se vieron afectadas las salidas de los vuelos por razones de seguridad tras el atentado del 11S?
%2.- ¿Qué región o regiones de E.E.U.U. suelen tener más cancelaciones de vuelos por razones climatológicas? 
%    ¿Existe algún motivo para ello? 
%3.- ¿Afectan los días/épocas festivos/as nacionales al número de vuelos y retrasos/cancelaciones en los aeropuertos?

clear; 

flights = datastore('airlinesmall.csv','SelectedVariableNames',{'Month','DepDelay'},'TreatAsMissing','NA');
preview(flights)

res = mapreduce(flights, @countMapper, @countReducer);
readall(res)