/*
 * Video mapping canvas test
 *
 * for Physical Computing midterm project: EXTRA
 * Stephanie Hagemeister + Nicolás Peña-Escarpentier
 * Fall 2017
 */

import processing.video.*;

Movie[] movs;
int movieCount = 2;
int currMov = 0;

void setup() {
  // canvas size
  //size(1920, 1080); // 1080p
  //size(1280, 720);  // 720p
  size(800, 600);   // 800x600

  // initialize and load movies array
  movs = loadMovies();
  // play first video
  movs[currMov].loop();
  movs[currMov].volume(0);
}

// run every time there's a new available frame
void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(0);
  image(movs[currMov], 20, 20, 640, 360);
}
 
Movie[] loadMovies() {
  // create array
  Movie[] movieList = new Movie[movieCount];
  // load files
  movieList[0] = new Movie(this, "static.mp4");
  movieList[1] = new Movie(this, "dramabug.mp4");
  // return
  return movieList;
}

// keyboard controls for testing
void keyPressed(){
  if(key == '0'){
    currMov = 0;
  } else if(key == '1'){
    currMov = 1;
  }
  
  // stop all the movies and loop the one that was selected
  for(int i=0; i<movs.length; i++){
    movs[i].stop();
  }
  movs[currMov].loop();
  movs[currMov].volume(0);
}