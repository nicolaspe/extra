/* //<>//
 * EXTRA
 * Video mapping sketch
 *
 * Physical Computing - NYU ITP
 * Stephanie Hagemeister + Nicolás Peña-Escarpentier
 * Fall 2017
 */

import processing.video.*;
import processing.serial.*;
import codeanticode.syphon.*;

// canvas for video mapping
PGraphics[] canvas;
SyphonServer[] server;

// resolution
int w = 1280;
int h = 800;

// video variables 
String[] videoList = {"static.mp4", 
  "FastFoodCommercials.mp4", 
  "FunnyCandyCommercials.mp4",
  "GoldenGlobesArrivals.mp4",
  "SensationalismMontage.mp4",
  "WorstMomentsPaparazzi.mp4",
  "YearWorldWentCrazy"};
Movie[] vids;
int currMov = 0;
int[] activeVid = {1, 2, 3};  // active videos according to the zone

// zones positions and boundaries [zone index][xpos, ypos, width, height]
int[][] zones = {{w/2, 0, w/2, h}, 
                 {20, 20, 320, 180}, 
                 {400, 200, 200, 180}}; 

// boolean for mode control
boolean extraMode = false;


void setup() {
  // create internal and external canvas
  size(200, 200, P3D);
  canvas = createGraphics(w, h, P3D);

  // create Syphon server
  server = new SyphonServer(this, "Processing Syphon");

  // initialize and load videos
  vids = new Movie[videoList.length];
  for (int i=0; i<videoList.length; i++) {
    vids[i] = new Movie(this, videoList[i]);
  }

  // play first video
  vids[0].loop();
  vids[0].volume(0);
}

void draw() {
  background(0);
  
  // draw things on canvas!
  canvas.beginDraw();
  canvas.background(0);

  // display videos in the corresponding zones
  if (!extraMode) {
    displayVid(0, 0);
  } else {
    for (int i=0; i<activeVid.length; i++) {
      displayVid(activeVid[i], (i+1));
    }
  }
  
  canvas.endDraw();
  //image(canvas, 0, 0);      // duplicates the canvas to the screen
  server.sendImage(canvas); // sends through syphon
}


/*
 * == MOVIES ==
 */

// run every time there's a new available frame
void movieEvent(Movie m) {
  m.read();
}

// displays a video to the target zone and target dimensions
// preserves the proportions and centers the image
void displayVid(int vid_i, int zone_i) {
  // create temp target image and variables
  PImage img = vids[vid_i];
  int xpos = zones[zone_i][0];
  int ypos = zones[zone_i][1];
  int wid = zones[zone_i][2];
  int hei = zones[zone_i][3];

  // display
  //image(img, xpos, ypos, wid, hei);
  canvas.image(img, xpos, ypos, wid, hei);
}


/*
 * == CONTROLS ==
 */
// keyboard controls for testing
void keyPressed() {
  if (key == 'm' || key == 'M') {
    changeMode();
  } else if (key == 'n' || key == 'N') {
    if(extraMode) randomVideo();
  }
}

void changeMode() {
  // switch mode
  extraMode = !extraMode;

  if (!extraMode) {
    // on "OFF" mode, just show white noise
    int[] aux = {0}; 
    loadVideos(aux, 0);
  } else {
    // otherwise, start all the other active videos
    loadVideos(activeVid, 0);
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
    vids[vid_index].volume(0);
  }
}

// replaces one of the active videos with a new random one
void randomVideo(){
  // get a random zone (zone 0 is the white noise case, so we avoid it)
  int randomZone = floor(random(zones.length -1));
  while(true){
    // get a random (inactive) video to display
    int randomVid = floor(random(vids.length -1)) +1;
    // check if the video is already active 
    if(isActive(randomVid)){
      // do nothing and loop to get another number
    } else {
      // load the selected video
      int[] aux = {randomVid};
      loadVideos(aux, activeVid[randomZone]);
      // replace it in the array
      activeVid[randomZone] = randomVid;
      // and BREAK! out of the loop
      break;
    }
  }
}

// checks whether a video is in the active video list or not
boolean isActive(int index){
  for(int i=0; i<activeVid.length; i++){
    if(index == activeVid[i]) return true;
  }
  return false;
}