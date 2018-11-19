class Flock {
  ArrayList<Boid> boids;
  float sepIndex, aliIndex, cohIndex;
  Flock() {
    boids = new ArrayList<Boid>();
    sepIndex = 1.2;
    aliIndex = 1.5;
    cohIndex = 1.2;
  }

  void flock(Boid indivisual, ArrayList<Boid> group) {
    PVector sep = indivisual.separate(group);
    PVector ali = indivisual.align(group);
    PVector coh = indivisual.cohesion(group);
    
    sep.mult(sepIndex);
    ali.mult(aliIndex);
    coh.mult(cohIndex);
    
    indivisual.applyForce(sep);
    indivisual.applyForce(ali);
    indivisual.applyForce(coh);
  }
  
  void run() {
    for(Boid b : boids) {
      flock(b,boids);
      b.update();
      b.checkEdges();
      b.render();
    }
  }
  
  void addBoid(Boid b) {
    boids.add(b);
  }
}
