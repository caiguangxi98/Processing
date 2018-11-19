Flock flock;
float n1 = 1;
float n2 = 1;
float n3 = 1;
float m = 8;
float a = 1;
float b = 1;

void setup() {
  size(1280, 720, P3D);
  //fullScreen();
  smooth();
  flock = new Flock();
  float r = 120;
  int vertexCount = 1080;
  float unit = TWO_PI / vertexCount;
  for (float angle = 0; angle < TWO_PI; angle += unit) {
    float supR = superShape(angle);
    float x = width/2 + r * supR * cos(angle);
    float y = height/2 + r * supR * sin(angle);
    Boid b = new Boid(x, y);
    b.speed.set(-r*supR*sin(angle), r*supR*cos(angle));
    b.speed.normalize();
    b.speed.mult(random(1, 6));
    b.originSpeed = b.speed.copy();
    flock.addBoid(b);
  }
}

void draw() {
  fill(0, 10);
  noStroke();
  rect(0, 0, width, height);
  flock.run();
}

float superShape(float theta) {

  float part1 = 1 / a * cos(m / 4 * theta);
  part1 = abs(part1);
  part1 = pow(part1, n2);

  float part2 = 1 / b * sin(m / 4 * theta);
  part2 = abs(part2);
  part2 = pow(part2, n3);

  float part3 = pow(sqrt(part1 + part2), 1 / n1);

  if (part3 == 0) {
    return 0;
  }

  return (1 / part3);
}

void keyPressed() {
  if (key == 's') {
    flock.sepIndex = 3.2;
  } else if (key == 'a') {
    flock.aliIndex = 2.4;
  } else if (key == 'c') {
    flock.cohIndex = 3.6;
  }
}

void mousePressed() {
  flock.sepIndex = 1.2;
  flock.aliIndex = 1.5;
  flock.cohIndex = 1.2;
}
