
import processing.video.*;
import java.util.*;

static final int DELAY = 100;

Capture cam;
LinkedList<PImage> images = new LinkedList<PImage>();
PImage lastImage = null;
int lastCapture = millis();

void setup() {
  cam = new Capture(this, 640, 480, 30);
  cam.start();
  size(800, 600);
}

void draw() {
  refresh_webcam();
  if (need_to_capture()) {
    capture_new_image();
  }
  draw_image_grid();
}

boolean need_to_capture() {
  int now = millis();
  if (now - lastCapture > DELAY) {
    lastCapture = now;
    return true;
  }
  return false;
}

void capture_new_image() {
  lastImage.resize(0, 50);
  images.push(lastImage);
  if (images.size() > 157) {
    images.removeLast();
  }
}

void refresh_webcam() {
  if (cam.available()) {
    cam.read();
  }
  lastImage = cam.get();
}

void draw_image_grid() {
  int x = 0;
  int y = 0;
  for (PImage img : images) {
    image(img, x, y);
    x += img.width;
    if (x > width) {
      x = 0;
      y += img.height;
    }
  }
}