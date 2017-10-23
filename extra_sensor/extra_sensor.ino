/*
 * IR Distance Sensor tester
 */
 
#define sensorPin A0

void setup() {
  pinMode(sensorPin, INPUT);
  Serial.begin(9600);
}
 
void loop(){
  int sensorVal = analogRead(sensorPin);
  Serial.println(sensorVal);
}
