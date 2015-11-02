
final int MOVENESS = 2;
final int BOX_SIZE = 30;
final float REPULSION = 1;
final float RANGE = 100;

void setup() {
  size(800,600);
}

void draw() {
  background(255,255,255);
  draw_squares();
}

void draw_squares() {
  for (int i=-10; i<width; i += BOX_SIZE) {
    for (int j=-20; j<height; j += BOX_SIZE) {
      draw_shaking_square(i, j);
    }
  }
}

void draw_shaking_square(int x, int y) {
  stroke(255, 255, 255);
  fill(255*x/width, 255*y/height, 255*(x+y)/(width+height));
  float xx = x + (x - mouseX) * gaussian(distance(x,y,mouseX,mouseY));
  float yy = y + (y - mouseY) * gaussian(distance(x,y,mouseX,mouseY));
  rect(xx+random(MOVENESS), yy+random(MOVENESS), BOX_SIZE*.9, BOX_SIZE*.9);
}

float distance(int x1, int y1, int x2, int y2) {
  return sqrt(pow(x1-x2, 2) + pow(y1-y2, 2));
}

float gaussian(float x) {
  return REPULSION * exp(-pow(x/RANGE, 2));
}