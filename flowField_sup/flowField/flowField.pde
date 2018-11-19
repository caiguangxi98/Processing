ArrayList<Particle> particles;
ArrayList<PVector> parLoc;
PImage pic;      //declare 'PImage' outside of the setup()

void setup() {
  size(1920, 1080, P3D);
  //fullScreen();
  frameRate(24);

  pic = loadImage("rain1.png");  //loadImage() inside the setup()

  parLoc = new ArrayList<PVector>();    //record the pixels location
  particles = new ArrayList<Particle>();

  for (int i = 0; i < width; i=i+3) {
    for (int j = 0; j < height; j=j+3) {
      color c = pic.get(i, j);
      float alpha = alpha(c);
      //if have alpha, add the location and add particles
      if (alpha != 0) {
        PVector loc = new PVector(i, j);
        //make sure that the num of the particles is the same as loc
        parLoc.add(loc);
        particles.add(new Particle());
      }
    }
  }
}

void draw() {
  fill(0, 10);  //a way to make background, alpha is important
  noStroke();
  rect(0, 0, width, height);

  for (int i = 0; i < particles.size(); i++) {
    particles.get(i).run();
  }

  //reset the particles if mouse pressed
  if (key == ' ') {
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      PVector ploc = parLoc.get(i);
      p.loc.lerp(ploc, 0.03);
    }
  }

  //if (mousePressed) {
  //  for (int i = 0; i < particles.size(); i++) {
  //    particles.get(i).badRun();
  //  }
  //}

  //saveFrame();
}
