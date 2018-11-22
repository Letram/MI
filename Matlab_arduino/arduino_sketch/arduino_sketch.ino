int potenciometro_pin=0; //Analog 0
int valor_potenciometro=0;

void setup(){
  Serial.begin(9600);
}
void loop(){
  valor_potenciometro=analogRead(potenciometro_pin);
  Serial.println(valor_potenciometro);
  delay(100);
}
