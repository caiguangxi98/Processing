class Particle {
  PVector pos;
  float life, lifeRate;
  
  Particle() {
    getPosition();
    life = random(0.75,1.25);
    lifeRate = random(0.018, 0.036);
  }
  
  void update() {
    float angle = noise(pos.x * 0.01, pos.y * 0.01) * TWO_PI;
    PVector vel = PVector.fromAngle(angle + globalRotation);
    pos.add(vel);
    life -= lifeRate;
  }
  
  void display() {
    boolean special = random(1) < 0.001;
    stroke(255, special ? random(175, 225) : 125);
    strokeWeight(special ? random(0.5, 3) : 0.75);
    point(pos.x, pos.y);
  }
  
  void getPosition() {
    while(pos == null || !isInside(pos) == true) {
      pos = new PVector(random(width), random(height));
    }
  }
  
  boolean isInside(PVector p) {
    color c = pg.get(int(p.x), int(p.y));
    return c == TEXT_COLOR;
  }
}
