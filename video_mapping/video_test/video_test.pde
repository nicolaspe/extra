/*
 * Video mapping canvas test
 *
 * for Physical Computing midterm project: EXTRA
 * Stephanie Hagemeister + Nicolás Peña-Escarpentier
 * Fall 2017
 */

import processing.video.*;
Movie[] movs;
int movieCount = 3;

void setup() {
  // initialize and load movies array
  movs = loadMovies();
}

// run every time there's a new available frame
void movieEvent(Movie m) {
  m.read();
}

void draw() {

}

Movie[] loadMovies() {
  // create array
  Movie[] movieList = new Movie[movieCount];

  // load files
  movieList[0] = "";
  movieList[1] = "";
  movieList[2] = "";
  movieList[3] = "";
  movieList[4] = "";
  movieList[5] = "";
  movieList[6] = "";

  return movieList;
}
