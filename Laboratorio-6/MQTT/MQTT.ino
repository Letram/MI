#include <SPI.h>
#include <Ethernet.h>
#include <PubSubClient.h>
// #include <DHT.h>

// #define DHTPIN 2
// #define DHTTYPE DHT11

// Direccion MAC
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = {10, 22, 147, 24}; 
// IP del servidor
IPAddress mqtt_server(192, 168, 0,20);

// Topic con el que trabajamos
//const char* topicName = "/master/Rayco";
const char* topicName = "channels/646959/publish/fields/1/VMPXWX1HV7SAFLF8";
//const char* server = "test.mosquitto.org";
const char* server = "mqtt.thingspeak.com";
// DHT dht(DHTPIN, DHTTYPE);
EthernetClient ethClient;
PubSubClient client(ethClient);

void setup()
{
  Serial.begin(9600);
  //Ethernet.begin(mac, ip);
  if (Ethernet.begin(mac) == 0) {
    Serial.println("Failed to configure Ethernet using DHCP");
    for (;;)
      ;
  }
  else {
    Serial.print("IP asignada por DHCP: ");
    Serial.println(Ethernet.localIP());
  }
  client.setServer(server, 1883);
  //dht.begin();
}

void loop()
{
  if (!client.connected()) {
    Serial.print("Connecting ...\n");
    client.connect("Arduino Client");
  }
  else {
    Serial.print("Conneced ...\n");
    // Envio
    // float temp = dht.readTemperature()// ;
    //char buffer[10];
    //dtostrf(temp,0, 0, buffer);
     int sensorValue = analogRead(A0);
  // Convert the analog reading (which goes from 0 - 1023) to a voltage (0 - 5V):
  float voltage = sensorValue * (5.0 / 1023.0);
  // print out the value you read:
  Serial.println(voltage);
  char buffer[10];
  dtostrf(voltage,10, 2, buffer);
    Serial.print(buffer);
    client.publish(topicName, buffer);
  }
  // Tiempo entre envios (en ms)
  delay(15000);
}
