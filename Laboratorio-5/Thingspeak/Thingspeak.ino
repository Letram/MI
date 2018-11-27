#include <Event.h>
#include <Timer.h>
#include <ThingSpeak.h>
#include <SPI.h>
#include <Ethernet.h>

#define DHT22_PIN 7

byte mac[] = {0x90, 0xA2, 0xDA, 0x0F, 0x70, 0x87};  //Sustituir YY por el numero de MAC correcto
byte ip[] = {10, 22, 147, 25}; 

EthernetClient client;
Timer t;

boolean estado_boton;

unsigned long myChannelNumber = 635034;
const char * myWriteAPIKey = "6QYZ6BRDU5J6R9GV";

void setup() {
  pinMode(6, INPUT_PULLUP);
  estado_boton = digitalRead(6);
  Ethernet.begin(mac, ip);
  ThingSpeak.begin(client);
  Serial.begin(9600);
  t.every (5000, grabaDatos, 10);
}

void loop() {
  t.update();
  boolean boton = digitalRead(6);
  if (boton != estado_boton) {
    Serial.print("Boton: ");
    Serial.println(boton);
    estado_boton = boton;
    grabaDatos();
  }
}

void grabaDatos() {
  Serial.println("leyendo datos... ");
  boolean boton = digitalRead(6);
  int sensorVal = analogRead(A0);
  float voltage = (sensorVal / 1024.0) * 5.0;
  float temperature = (voltage - 0.5) * 100; //Sonda temperatura kit Arduino
  Serial.print("Temperatura Leida: ");
  Serial.println(temperature);
  int pot = analogRead(A1);
  Serial.print("Potenciometro: ");
  Serial.println(pot);
  Serial.println(Ethernet.localIP());
  ThingSpeak.setField(1, pot);
  ThingSpeak.setField(2, temperature);
  ThingSpeak.setField(3, boton);
  ThingSpeak.writeFields(myChannelNumber, myWriteAPIKey);
}

