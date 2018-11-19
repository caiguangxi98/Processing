class Particle {
  PVector loc, mloc, vel, acc;
  color col;
  float maxVel = 1.8;
  float rad;
  float w = 500.0;
  float h = 500.0;

  Particle() {
    loc = new PVector(random(width*1.2), random(height));
    mloc = loc.copy();
    rad = random(TWO_PI);
    vel = new PVector(0, 0);
    acc = new PVector(cos(rad), sin(rad));
  }

  void run() {
    move();
    checkEdges();
    display();
  }

  void move() {
    float deg;
    if (key == 'a') {
      deg = 360 * (noise(loc.x/w, loc.y/h, millis() / 1202)*4.2);
    } else if (key == 's') {
      deg = 360 * (noise(loc.x/w, loc.y/h, millis() / 4602)*2.2);
    } else if (key == 'd') {
      deg = 360 * (noise(loc.x/w, loc.y/h, millis() / 2802)*1.8);
    } else {
      deg = 360 * (noise(loc.x/w, loc.y/h, millis() / 3602)*1.2);
    }
    rad = radians(deg);
    acc.set(cos(rad), sin(rad));
    vel.add(acc);

    if (vel.magSq() > maxVel) {
      vel.normalize();
      vel.mult(maxVel);
    }

    mloc = loc.copy();
    loc.add(vel);
  }

  void checkEdges() {
    if (loc.x < 0 || loc.x > width || loc.y < 0 || loc.y > height) {
      loc.x = random(width * 1.2);
      loc.y = random(height);
      mloc = loc.copy();
    }
  }

  void display() {
    colorMode(HSB, 360, 100, 100);
    float alpha = 230 * noise((millis()+loc.x * loc.y)/1813.1);
    float hue = 0;
    if (key == 'p') {
      hue = 100 + 250 * noise((millis()+loc.x * loc.y)/600.0);
    } else {
      hue = 100 + 220 * noise((millis()+loc.x * loc.y)/200.0);
    }
    stroke(hue, 85, 97, 42 + alpha);
    strokeWeight(1.8);
    line(loc.x, loc.y, mloc.x, mloc.y);
  }
}
