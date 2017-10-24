/*
 * EXTRA 
 * Arduino component
 * 
 * Physical Computing - NYU ITP
 * Stephanie Hagemeister + Nicolás Peña-Escarpentier
 * Fall 2017
 */

#define echoPin 7
#define trigPin 8

#include <Servo.h>
Servo myServo;

int threshold = 36; // inch

void setup() {
  // Pin setup
  pinMode(echoPin, INPUT);
  pinMode(trigPin, OUTPUT);
  
  myServo.attach(3);

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
  distance = (duration/2) /(29.1 *2.54);

  // open/close media according to distance and threshold
  if (distance <= threshold){   // CLOSE!
    Serial.println("CLOSE");
    closeNews();
  } else {                      // OPEN!
    Serial.println("OPEN");
    openNews();
  }

  // wait
  delay(200);
}


// CONTROL FUNCTIONS
void openNews() {
  myServo.write(140);
}

void closeNews() {
  myServo.write(0);
}

