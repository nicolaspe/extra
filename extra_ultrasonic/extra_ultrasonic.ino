/*
 * Ultrasonic Range Sensor test
 */

#define echoPin 7
#define trigPin 8

void setup() {
  // Pin setup
  pinMode(echoPin, INPUT);
  pinMode(trigPin, OUTPUT);

  Serial.begin(9600);
}

void loop() {
  // variables
  long duration, distance;
  
  // send a trigger pulse
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // read the PULSE
  duration = pulseIn(echoPin, HIGH);
  distance = (duration/2) /29.1;

  // output
  if (distance >= 2000 || distance <= 0){
    Serial.println("Too Far");
  }
  else {
    Serial.print(distance/2.54);
    Serial.println(" inch");
  }
  delay(200);

}
