m = rand(10);
maxim = max(m);
minim = min(m);
channelID = 622946;
writeKey  = 'TLLJ9K1EFJEXF39W';
for i = 1:10
    thingSpeakWrite(channelID,'Fields', [1,2], 'Values', {maxim(i), minim(i)}, 'WriteKey', writeKey);
    pause (20);
end
