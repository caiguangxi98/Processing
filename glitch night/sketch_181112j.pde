void setup() {
  size(960, 960);
}

void draw() {
  background(0);
  
  noStroke();
  colorMode(HSB);
  float count = 453;

  beginShape();

  translate(width/2, height/2);
  for (int i = 0; i < count; i++) {
    //float x = 18.8 * noise((millis()+i)/800.0, 0.0);
    //float y = 20.2 * noise(0.0, (millis()+i)/800.0);
    float r = 170 + 61.4 * noise((millis()+i*2164)/800.0);
    float alpha = 213 * noise((millis()+i)/1813.1);
    float hue01 = 135 * noise((millis()+i*1388)/1600.0);
    float hue02 = 245 * noise((millis()+i*1251)/4600.0);
    float sw = 1.0 + 1.3 * noise((millis()+i)/1800.0);

    float unit = 360.0 / count;
    float vx = sin(radians(unit*i))*r;
    float vy = cos(radians(unit*i))*r;

    float lx = -138*sin(radians(unit*i))*r;
    float ly = -1710*cos(radians(unit*i))*r;

    stroke(hue01+hue02, 234, 238, 80 + alpha);
    strokeWeight(sw);
    line(lx, ly, vx, vy);
  }

  endShape();
}  
