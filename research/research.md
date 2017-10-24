

## Sensors!

#### PIR Motion sensor
[Product](https://www.adafruit.com/product/189) | [Tutorial](https://learn.adafruit.com/pir-passive-infrared-proximity-motion-sensor)

#### Other options
- [IR Distance Sensor](https://www.adafruit.com/product/1568): detects between 1 - 5m. "The analog voltage out will range from 3V when an object is about 100cm away and 1.4V when the object is 500cm away".
- [Maxbotix Ultrasonic Rangefinder](https://www.adafruit.com/product/984): detects from 1mm to 5m! Outputs RS-232 serial data.

#### Ultrasonic Range Finder
- [Datasheet](https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf)
- [Example 1](http://www.instructables.com/id/Simple-Arduino-and-HC-SR04-Example/)
- [Example 2](http://tinkersphere.com/documents/TS-126UltrasonicArduinoSketch.txt)

Trigger sends the signal and echo reads the result.


## Software

#### Processing (with video library)
- [Link](https://processing.org/)

mov files + `img.scale`

Cannot load videos from a parent folder. Ex: `"../media/filename.mp4"`, they can only be loaded from `"/data/filename.mp4"` and the data folder does not have to be written on the code (`new Movie(this, "filename.mp4")`)

[disable movie sound documentation](https://forum.processing.org/one/topic/how-disable-sound-in-movie.html): has to be user AFTER the video is started/looped. Volume range 0-1. Stops working after first time?

resize does not work well on video frames... use code from the Frames example
![artifacts when resize]()

for the `loadVideos` function, I need to make two "modes", meaning two different input possibilities... for when I have to load all the videos when changing mode, or for when I just want to replace one video.

If the videos are too large, the program crashes!

"Transparent" background? `clear()` works perfectly! [Link](https://forum.processing.org/one/topic/pgraphics-transparency.html)


#### Syphon + MadMapper
- [Syphon](http://syphon.v002.info/)
- [MadMapper](http://madmapper.com/)

[How to use them together](https://www.youtube.com/watch?v=ItfCvU6jc5E)
[Another link](https://socram484.wordpress.com/2013/09/12/using-syphon-with-processing-into-madmapper/)

## Video resources
- [White noise](https://www.youtube.com/watch?v=DH0BQtwEAsM)
