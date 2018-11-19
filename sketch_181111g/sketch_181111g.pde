void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  //float r = 100;
  float cx = width/2;
  float cy = height/2;
  noFill();
  stroke(255);
  strokeWeight(2);
  beginShape();
  for (int i = 0; i <= 360; i = i + 6) { 
    float deg = millis() / 3.5 + i * 85;
    float mrad = radians(deg);
    float pingPong = sin(mrad);
    float r = map(pingPong, -1.0, 1.0, 5.4, 120.0);
    float rad = radians(i);
    float x = cx + sin(rad) * r;
    float y = cy + cos(rad) * r;
    vertex(x, y);
  }
  endShape(CLOSE);
}
