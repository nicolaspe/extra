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


void setup() {
  // canvas size
  // size(1920, 1080); // 1080p
  size(1280, 720);  // 720p

  // initialize and load movies array
  movs = loadMovies();
}

// run every time there's a new available frame
void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(0);
  image(movs[1], 0, 0, 620, 480);
}

Movie[] loadMovies() {
  // create array
  Movie[] movieList = new Movie[movieCount];
  // load files
  movieList[0] = new Movie(this, "../media/static.mp4");
  movieList[1] = new Movie(this, "../media/dramabug.mp4");
  // movieList[2] = "";
  // movieList[3] = "";
  // movieList[4] = "";
  // movieList[5] = "";
  // movieList[6] = "";
  // return
  return movieList;
}