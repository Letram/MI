

readChannelID = 657542; 

readAPIKey = 'E5SKLO16R4DPR9WE'; 

fileName = 'datos.txt';
handler= fopen(fileName,'a');
s = dir(fileName);
if(s.bytes <= 0 )
    fprintf(handler, 'Date;hour;temperatura\n');
end
contador = 0;
while contador < 240
    tempF = thingSpeakRead(readChannelID,'Fields',1 ,'NumPoints',1, 'ReadKey',readAPIKey); 
    now = datetime('now');
    temp = strtrim(num2str(tempF(1)));
    fprintf(handler, '%s;%s;%s\n', datestr(now,'dd/mm/yyyy'), datestr(now,'HH:MM'),temp);
    contador = 1 +contador;
    pause(25);
end
fclose(handler);