/* //<>//
 * EXTRA
 * Video mapping sketch
 *
 * Physical Computing - NYU ITP
 * Stephanie Hagemeister + Nicolás Peña-Escarpentier
 * Fall 2017
 */

import processing.video.*;
import codeanticode.syphon.*;
import processing.serial.*;

// canvas for video mapping
int nServers = 5;
PGraphics[] canvas;
SyphonServer[] server;

// canvas resolution
int w = 1280;
int h = 800;

// Serial communication
Serial myPort;
String portName = "/dev/cu.usbmodem1421";
int serialMsg = 0;

// video variables
String[] videoList = {"static.mp4",
  "FastFoodCommercials.mp4",
  "FunnyCandyCommercials.mp4",
  "GoldenGlobesArrivals.mp4",
  "SensationalismMontage.mp4",
  "WorstMomentsPaparazzi.mp4",
  "YearWorldWentCrazy.mp4"};
Movie[] vids;
int[] activeVid;  // active videos corresponding to each canvas

// boolean for mode control
boolean extraMode = false;


void setup() {
  // internal control screen
  size(400, 400, P3D); //<>//

  // create projected canvases
  canvas = new PGraphics[nServers];
  for (int i=0; i<nServers; i++) {
    canvas[i] = createGraphics(w, h, P3D);
  }

  // create Syphon servers
  server = new SyphonServer[nServers];
  for (int i=0; i<nServers; i++) {
    server[i] = new SyphonServer(this, "ProceSyphon_" +i);
  }

  // Serial setup
  //printArray(Serial.list());
  myPort = new Serial(this, portName, 9600);

  // load videos
  vids = new Movie[videoList.length];
  for (int i=0; i<videoList.length; i++) {
    vids[i] = new Movie(this, videoList[i]);
  }
  activeVid = new int[nServers -1];
  for (int i=1; i<nServers; i++) {
    activeVid[i] = i;
  }

  // play first videos
  vids[0].loop();
  //vids[0].volume(0);
  changeMode(serialMsg);
}

void draw() {
  background(0);

  // reset all canvas (draw only backgrounds)
  for (int i=0; i<nServers; i++) {
    canvas[i].beginDraw();
    canvas[i].clear();
    canvas[i].endDraw();
  }

  // read Serial information
  if(myPort.available() > 0){
    serialMsg = myPort.read();
    changeMode( serialMsg );
  }

  // randomize videos if in extraMode
  if (frameCount%7200 == 0 && extraMode) randomVideo();

  // display videos in the corresponding zones
  if (!extraMode) {        // display static in canvas 0
    displayVid(0, 0);
  } else {                 // display videos in corresponding canvases
    for (int i=0; i<activeVid.length; i++) {
      displayVid(activeVid[i], (i+1));
    }
  }

  // display on internal screen
  //image(canvas[0], 0, 0, width/2, height/2);
  //image(canvas[1], width/2, 0,  width/2, height/2);
  //image(canvas[2], 0, height/2, width/2, height/2);
  //image(canvas[3], width/2, height/2, width/2, height/2);

  // send images via Syphon
  for (int i=0; i<nServers; i++) {
    server[i].sendImage(canvas[i]); // sends through syphon
  }
}


/*
 * == MOVIES ==
 */

// run every time there's a new available frame
void movieEvent(Movie m) {
  m.read();
}

// displays a video to the target canvas
void displayVid(int vid_i, int canvas_i) {
  // create temp target image and variables
  PImage img = vids[vid_i];
  int wid = canvas[canvas_i].width;
  int hei = canvas[canvas_i].height;

  // display
  canvas[canvas_i].beginDraw();
  canvas[canvas_i].image(img, 0, 0, wid, hei);
  canvas[canvas_i].endDraw();
}


/*
 * == CONTROLS ==
 */

// keyboard controls for testing
void keyPressed() {
  if (key == 'm' || key == 'M') {
    //changeMode();
  } else if (key == 'n' || key == 'N') {
    if (extraMode) randomVideo();
  }
}

void changeMode(int m) {
  if (m == 0) {              // NOISE MODE
    extraMode = false;
    // on "OFF" mode, just show white noise
    int[] aux = {0};
    loadVideos(aux, 0);
  } else if (m == 1) {       // EXTRA MODE
    extraMode = true;
    // otherwise, start all the other active videos
    loadVideos(activeVid, 0);
    // and randomize two of them
    randomVideo();
    randomVideo();
  }
}

// function that changes the active movie
void loadVideos(int[] play_index, int stop_index) {

  // choose which videos to stop
  if (stop_index == 0) { // stop all the videos
    for (int i=0; i<vids.length; i++) {
      vids[i].stop();
    }
  } else {               // stop only the specified video
    vids[stop_index].stop();
  }

  // loop (and mute) the one(s) selected
  for (int i = 0; i<play_index.length; i++) {
    int vid_index = play_index[i];
    vids[vid_index].loop();
    //vids[vid_index].volume(0);
  }
}

// replaces one of the active videos with a new random one
void randomVideo() {
  // get a random canvas (zone 0 is the white noise case, so we avoid it)
  int randomCanvas = floor(random(nServers -1));
  while (true) {
    // get a random video to display
    int randomVid = floor(random(vids.length -1)) +1;

    // check if the video is already active
    if (isActive(randomVid)) {
      ; // do nothing and loop to get another number
    } else {
      // load the selected video
      int[] aux = {randomVid};
      loadVideos(aux, activeVid[randomCanvas]);

      // replace it in the active array
      activeVid[randomCanvas] = randomVid;

      // and BREAK! out of the loop
      break;
    }
  }
}

// checks whether a video is in the active video list or not
boolean isActive(int index) {
  for (int i=0; i<activeVid.length; i++) {
    if (index == activeVid[i]) return true;
  }
  return false;
}
