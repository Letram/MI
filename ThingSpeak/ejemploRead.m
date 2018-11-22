readChannelID = 68785;
writeChannelID = 622946;
writeKey = 'TLLJ9K1EFJEXF39W';

fieldToRead = 3;

%data = thingSpeakRead(channelID, 'Fields', fieldToRead);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfPoints = 200;

for i = 1 : numberOfPoints
    [data, timestamp] = thingSpeakRead(readChannelID, 'Fields', fieldToRead);
    thingSpeakWrite(writeChannelID, 'Fields', 3, 'Values', data, 'WriteKey', writeKey);
    pause(20);
end