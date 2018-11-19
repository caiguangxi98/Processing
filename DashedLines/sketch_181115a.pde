import garciadelcastillo.dashedlines.*;

DashedLines dash;

void setup() {
  size(800, 800);
  strokeWeight(5);
  strokeCap(SQUARE);
  textAlign(CENTER);
  dash = new DashedLines(this);
}

void draw() {
  noStroke();
  fill(255, 5);
  rect(0, 0, width, height);

  noFill();
  colorMode(HSB);
  dash.pattern(10, 20, 30, 40);

  for (int i = 1; i <= 45; i++ ) {
    float sw = map(sin(radians((millis()+i*45.3)/5.6)), -1, 1, 70.3, 1.6);
    //stroke(map(i,1,45,1,255), 235, 231, 56);
    //strokeWeight(sw);
    stroke(sw);
    drawDashPoly(64, 5*i);
  }

  dash.offset(millis()/10.0);
}

void drawDashPoly(int count, float r) {
  pushMatrix();
  translate(width/2, height/2);
  dash.beginShape();
  for (int i = 0; i <= count; i++) {
    float unit = 360.0 / count;
    float pingPong = sin(radians((millis()/3.5+i*999.9)/8.8));
    float mr = r + map(pingPong, -1, 1, 13.3, 89.5);
    float x = mr * sin(radians(unit*i));
    float y = mr * cos(radians(unit*i));
    dash.vertex(x, y);
  }
  dash.endShape(CLOSE);
  popMatrix();
}
