%DONE - Representar el Histograma de los valores y localizar el máximo.
%DONE - Con el Arduino pasar un texto de alerta a Matlab en el caso de que se supere ese valor máximo.
%DONE - Crear un canal en ThingSpeak llamado Arduino.
%DONE - Visualizar en el los valores del voltímetro.
%Visualizar también el texto en caso de alarma y publicarlo en Twitter en una cuenta creada para la práctica
%Realizar Breve informe.
function matlab_exercise (numero_muestras)
	
    channelID = 629236;
    writeKey = 'RPCTN9NEBI9AQVUN';

    close all;
	clc;
	y = zeros(1,1000); %Vector donde se guardarán los datos
	%Inicializo el puerto serial que utilizaré
	delete(instrfind({'Port'},{'COM3'}));
	puerto_serial=serial('COM3');
	puerto_serial.BaudRate=9600;
	warning('off','MATLAB:serial:fscanf:unsuccessfulRead');
	

	%Abro el puerto serial
	fopen(puerto_serial); 
	
	%Declaro un contador del número de muestras ya tomadas
	contador_muestras=1;
    
	%Bucle while para que tomelas muestras que queremos
    
    %El máximo suele rondar 2.05 (max(y)), pero probamos con 2 por si aca
	while contador_muestras <= numero_muestras
	        valor_potenciometro = fscanf(puerto_serial,'%d')';
	        y(contador_muestras) = (valor_potenciometro(1))*5/1024;
            if(1.8 < (valor_potenciometro(1))*5/1024)
                thingSpeakWrite(channelID, 'Fields', [1,3] ,'Values' ,{y(contador_muestras), y(contador_muestras)}, 'WriteKey', writeKey);
                webwrite('https://api.thingspeak.com/apps/thingtweet/1/statuses/update', 'api_key', 'VM1MRBP2X291VRS9', 'status', 'Publicación en caso de alarma...' );
            else
                thingSpeakWrite(channelID, y(contador_muestras), 'WriteKey', writeKey);
            end
	        contador_muestras = contador_muestras + 1;
            pause(20);
    end
    
	%Cierro la conexión con el puerto serial y elimino las variables
	fclose(puerto_serial); 
	delete(puerto_serial);
    
	clear all;
end