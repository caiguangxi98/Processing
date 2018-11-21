PGraphics pg;
color TEXT_COLOR = color(255);
color BACKGROUND_COLOR = color(0);
ArrayList<Particle> Particles = new ArrayList<Particle>();
int maxParticleNum = 8000;
float globalRotation;

void setup() {
  size(1280, 720, P3D);
  smooth(32);
  PFont f = createFont("Source Han Serif", 360);
  pg = createGraphics(width, height, JAVA2D);
  pg.beginDraw();
  //pg.textSize(420);
  pg.textFont(f);
  pg.textAlign(CENTER, CENTER);
  pg.fill(TEXT_COLOR);
  pg.text("如风", pg.width/2, pg.height/2);
  pg.endDraw();
  background(BACKGROUND_COLOR);
}

void draw() {
  fill(0, 12);
  noStroke();
  rect(0, 0, width, height);

  addRemoveParticles();
  for (Particle p : Particles) {
    p.update();
    p.display();
  }
}

void addRemoveParticles() {
  for (int i = Particles.size() - 1; i >= 0; i--) {
    Particle p = Particles.get(i);
    if (p.life <= 0) {
      Particles.remove(i);
    }
  }

  while (Particles.size() <= maxParticleNum) {
    Particles.add(new Particle());
  }
}

void keyPressed() {
  if (key == ' ') {
    background(BACKGROUND_COLOR);
    Particles.clear();
    globalRotation = random(TWO_PI);
  }
}
