void setup() {
  size(800, 800);
}

void draw() {
  background(0);
  noStroke();
  colorMode(HSB);
  for (int i = 10; i < width; i = i + 50) {
    for (int j = 10; j < height; j = j + 50) {
      float x = 18.8 * noise((millis()+i*j)/800.0, 0.0);
      float y = 20.2 * noise(0.0, (millis()+i*j)/800.0);
      float r = 19.4 * noise((millis()+i*j)/800.0);
      float alpha = 224 * noise((millis()+i*j)/1800.0);
      float hue01 = 135 * noise((millis()+i*j)/1600.0);
      float hue02 = 245 * noise((millis()+i*j)/4600.0);
      fill(hue01+hue02, 234, 238, 6 + alpha);
      ellipse(i + x, j + y, 16 + r, 16 + r);
    }
  }
}  
