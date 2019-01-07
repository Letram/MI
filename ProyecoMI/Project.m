%Utilizando los datos relativos a los vuelos comerciales realizados entre los a�os 1.998 y 2.008, buscar respuesta y argumentaci�n a las siguientes preguntas:
%1.- �Se vieron afectadas las salidas de los vuelos por razones de seguridad tras el atentado del 11S?
%2.- �Qu� regi�n o regiones de E.E.U.U. suelen tener m�s cancelaciones de vuelos por razones climatol�gicas? 
%    �Existe alg�n motivo para ello?�
%3.- �Afectan los d�as/�pocas festivos/as nacionales�al n�mero de vuelos y retrasos/cancelaciones en los aeropuertos?

clear; 

flights = datastore('airlinesmall.csv','SelectedVariableNames',{'Month','DepDelay'},'TreatAsMissing','NA');
preview(flights)

res = mapreduce(flights, @countMapper, @countReducer);
readall(res)