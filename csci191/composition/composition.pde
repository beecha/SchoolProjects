/*
 * composition
 * Image composition with alpha channel.
 */

PImage top, bottom;
PImage dest;

void setup() {
  size(512,512);
  noStroke();
  
  top = loadImage("top.png");
  bottom = loadImage("bottom.png");
  dest = createImage(256,256,ARGB);
  
  // Draw background grid
  final int GRID_SIZE = 32;
  for(int y = 0; y < height/GRID_SIZE; y++)
    for(int x = 0; x < width/GRID_SIZE; x++) {
      fill((x+y) % 2 == 0 ? #777777 : #aaaaaa);
      rect(x*GRID_SIZE, y*GRID_SIZE, GRID_SIZE, GRID_SIZE);
    }
  
  loadPixels();
  top.loadPixels();
  bottom.loadPixels();
  dest.loadPixels();
  
  for(int y = 0; y < 256; y++)
    for(int x = 0; x < 256; x++) {
      //color z = pixels[(x + 128) + (y + 128)*width];
      color a = top.pixels[x + y*top.width];
      color b = bottom.pixels[x + y*bottom.width];
      
      //dest.pixels[x + y*dest.width] = ?
      //pixels[(x + 128) + (y + 128)*width] = ?
    }
  
  updatePixels();
  top.updatePixels();
  bottom.updatePixels();
  dest.updatePixels();
  
  image(dest,128,128);
}