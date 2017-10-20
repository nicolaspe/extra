/*
 * Video mapping , image canvas test
 *
 * for Physical Computing midterm project: EXTRA
 * Stephanie Hagemeister + Nicolás Peña-Escarpentier
 * Fall 2017
 */

import processing.video.*;

PImage[] imgs;
int imgCount = 2;


void setup() {
  // canvas size
  // size(1920, 1080); // 1080p
  size(1280, 720);  // 720p

  // initialize and load movies array
  imgs = loadImages();
}

void draw() {
  background(0);
  image(imgs[1], 0, 0, 620, 480);
}

PImage[] loadImages() {
  // create array
  PImage[] imgList = new PImage[imgCount];
  // load files
  imgList[0] = loadImage("../media/weezer.jpg");
  imgList[1] = loadImage("../media/arcadefire.jpg");
  // return
  return imgList;
}
