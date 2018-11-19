void setup() {
  size(800, 800);
  smooth();
  frameRate(60);
}

void draw() {
  background(0);
  noFill();
  colorMode(HSB);
  for (int i = 1; i <= 27; i++) {
    float deg = (millis()+i*80.3) / 7.66;
    float rad = radians(deg);
    float pingPong = sin(rad);
    float sw = map(pingPong, -1, 1, 73.6, 1.5);
    stroke(map(i, 1, 27, 1, 255), 235, 231, 56);
    strokeWeight(sw);
    drawPoly(15, 6 * i);
  }
}

void drawPoly(int count, float r) {
  pushMatrix();
  translate(width/2, height/2);
  beginShape();
  for (int i = 0; i <= count; i++) {
    float unit = 360.0 / count;
    float Prad = radians(unit * i);
    float mr = r + map(sin(radians((millis()+i*939)/7.8)), -1, 1, -157.5, 30.2);
    float x = sin(Prad) * mr;
    float y = cos(Prad) * mr;
    vertex(x, y);
  }
  endShape(CLOSE);
  popMatrix();
}
