/*
 * Video mapping canvas test
 *
 * for Physical Computing midterm project: EXTRA
 * Stephanie Hagemeister + Nicolás Peña-Escarpentier
 * Fall 2017
 */

import processing.video.*;

String[] videoList = {"static.mp4", "dramabug.mp4", "debate_supercut.mp4"};
Movie[] vids;
int currMov = 0;
int[] activeVid = {1,2};  // active videos according to the zone
// zones positions and boundaries [xpos, ypos, width, height]
int[][] zones = {{20, 20, 320, 180}, {400, 200, 200, 180}}; 
//int[][] zones = {{20, 20, 320, 180}};
//int[][] zones = {{400, 200, 200, 180}}; 

void setup() {
  // canvas size
  //size(1920, 1080); // 1080p
  //size(1280, 720);  // 720p //<>//
  size(800, 600);   // 800x600

  // initialize and load videos
  vids = new Movie[videoList.length];
  for(int i=0; i<videoList.length; i++){
    vids[i] = new Movie(this, videoList[i]);
  }
  
  // play first video
  vids[1].loop();
  vids[1].volume(0);
  vids[2].loop();
  vids[2].volume(0);
}

void draw() {
  background(0);
  
  // display videos in the corresponding zones
  for(int i=0; i<zones.length; i++){
    displayVid(activeVid[i], i);
  }
}


/*
 * == MOVIES ==
 */
 
// run every time there's a new available frame
void movieEvent(Movie m) {
  m.read();
}

// function that changes the active movie
void loadMovie(int index){
  // change "current movie" index
  currMov = index;

  // stop all the movies
  for(int i=0; i<vids.length; i++){
    vids[i].stop();
  }
  // loop (and mute) the one that was selected
  vids[currMov].loop();
  vids[currMov].volume(0);
}

// displays a video to the target zone and target dimensions
// preserves the proportions and centers the image
void displayVid(int vid_i, int zone_i){
  // create temp target image and variables
  PImage img = vids[vid_i];
  int xpos = zones[zone_i][0];
  int ypos = zones[zone_i][1];
  int wid = zones[zone_i][2];
  int hei = zones[zone_i][3];
  
  // == will redo later == 
  // calculate if the target image is the same proportion, wider or taller 
  // and resize+crop accordingly
  //float imgRatio  = (float) img.width/img.height;
  //float zoneRatio = (float) wid/hei;
  //print("Ratios: " +imgRatio +" - " +zoneRatio +" ");
  //if(imgRatio == zoneRatio){  // proportional!
  //  println("proportional!");
  //  //img.resize(wid, 0);
  //} else if (imgRatio > zoneRatio) {  // image wider, preserve scaled height!
  //  println("image wider, preserve scaled height");
  //  img.resize(0, hei);
  //  //img = cropX(img, wid);
  //} else {  // image taller, preserve scaled width!
  //  println("image taller, preserve scaled width");
  //  //img.resize(wid, 0);
  //  //img = cropY(img, hei);
  //}
  
  // display
  image(img, xpos, ypos, wid, hei);
}

// function to set(get) a specific frame from a video file 
// without fully playing it
// based on the setFrame function from the Frames example
void setFrame(int vid_i, int frame){
  // (re)start video to get next frame (and mute!)
  vids[vid_i].play();
  vids[vid_i].volume(0);
  
  // get frame duration and move to the middle of the frame
  float frameDuration = 1.0 / vids[vid_i].frameRate;
  float where = (frame + 0.5) * frameDuration;
  
  // taking into account border effects!
  float diff = vids[vid_i].duration() -where;
  if (diff < 0){
    where += diff - 0.25*frameDuration;
  }
  
  // go to the frame!
  vids[vid_i].jump(where);
  vids[vid_i].pause();
}

// function to crop the sides of an image
PImage cropX(PImage source, int xdim){
  // create target image and access it's pixels
  PImage croppedImg = new PImage(xdim, source.height, RGB);
  croppedImg.loadPixels();
  
  // establish left cropped boundary
  int lBound = source.width/2 - xdim/2;
  
  // iterate over the target image's pixels
  for(int x=0; x<xdim; x++){
    for(int y=0; y<croppedImg.height; y++){
      int loc = x + y*croppedImg.width;  // target pixel location in array
      int x2 = lBound + x;               // get x coordinate in source img
      int loc2 = x2 + y*source.width;    // get source pixel location in array
      color c = source.pixels[loc2];     // get source pixel color
      croppedImg.pixels[loc] = c;        // assign color in new location
    }
  }
  
  // update the pixels and return
  croppedImg.updatePixels();
  return croppedImg;
}

// function to crop the upper and lower part of an image
PImage cropY(PImage source, int ydim){
  // create target image and access it's pixels
  PImage croppedImg = new PImage(source.width, ydim);
  croppedImg.loadPixels();
  
  // update the pixels and return
  croppedImg.updatePixels();
  return source;
}


/*
 * == CONTROLS ==
 */
// keyboard controls for testing
void keyPressed(){
  if(key == '0'){
    //loadMovie(0);
  } else if(key == '1'){
    //loadMovie(1);
  }
}