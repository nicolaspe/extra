/*
   EXTRA
   Arduino component

   Physical Computing - NYU ITP
   Stephanie Hagemeister + Nicolás Peña-Escarpentier
   Fall 2017
*/

#define echoPin 7
#define trigPin 8

#include <Servo.h>
Servo myServo;

// timers
unsigned long previous_time   = 0;
unsigned long sensor_interval = 200;
unsigned long closing_timer   = 0;
unsigned long closing_interval= 15 * 1000;

int threshold = 100; // cm
boolean newsOpen = true;

void setup() {
  // Pin setup
  pinMode(echoPin, INPUT);
  pinMode(trigPin, OUTPUT);

  myServo.attach(3);
  myServo.write(0);

  Serial.begin(9600);
}

void loop() {
  // check time
  unsigned long current_time = millis();

  // sensor timed loop
  if (current_time - previous_time > sensor_interval) {
    // update time
    previous_time = current_time;

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
    distance = (duration / 2) / 29.1;
//    Serial.print(distance);
//    Serial.print(" - ");

    // open-close media according to distance and threshold
    if (distance >= 2000 || distance <= 7) {  // ERROR!
//      Serial.println("ERROR");
    } else if (distance <= threshold) {
//      Serial.println("CLOSE");
      closeNews();
      closing_timer = current_time;
    } else {
//      Serial.println();
    }
  }

  // check if enough time has passed to open the news again
  if(current_time - closing_timer > closing_interval && !newsOpen){
//    Serial.println("OPEN");
    openNews();
  }
  
}


// CONTROL FUNCTIONS
void openNews() {
  byte msg = 1;
  Serial.write(msg);
  myServo.write(0);
  newsOpen = true;
}

void closeNews() {
  byte msg = 0;
  Serial.write(msg);
  myServo.write(180);
  newsOpen = false;
}

