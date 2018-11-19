class Boid {
  PVector pos, originPos, speed, originSpeed, acc;
  float maxForce, maxSpeed, mass;
  float minSpacing;
  float averageSpeedRange;
  float averagePosRange;
  color col;

  Boid(float x, float y) {
    acc = new PVector(0, 0);
    speed = PVector.random2D();
    originSpeed = new PVector();
    pos = new PVector(x, y);
    originPos = new PVector(x, y);
    maxForce = random(0.04, 0.08);
    maxSpeed = random(4.0, 8.0);
    mass = random(1, 2);
    minSpacing = random(10, 30);
    averagePosRange = minSpacing * 4.0;
    averageSpeedRange = minSpacing * 2.0;
  }

  void applyForce(PVector force) {
    acc.add(force.div(mass));
  }

  void update() {
    speed.add(acc);
    speed.limit(maxSpeed);
    pos.add(speed);
    acc.mult(0);
  }

  PVector seek(PVector target) {
    PVector go = PVector.sub(target, pos);
    go.normalize();
    go.mult(maxSpeed);
    PVector seekForce = PVector.sub(go, speed);
    seekForce.limit(maxForce);
    return seekForce;
  }

  PVector escape(PVector target) {
    PVector run = PVector.sub(pos, target);
    run.normalize();
    run.mult(maxSpeed);
    PVector escapeForce = PVector.sub(run, speed);
    escapeForce.limit(maxForce);
    return escapeForce;
  }

  void attract(PVector target) {
    applyForce(seek(target));
  }

  void checkEdges() {
    if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      pos.set(originPos);
      pos.add(new PVector(random(-60, 60), random(-60, 60)));
      acc = new PVector(0, 0);
      speed = originSpeed.copy();
    }
  }

  PVector separate(ArrayList<Boid> boids) {
    PVector sepForce = new PVector(0, 0);
    //int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(pos, other.pos);
      if ((d > 0) && (d < minSpacing)) {
        PVector diff = PVector.sub(pos, other.pos);
        diff.normalize();
        sepForce.add(diff);
        //count++;
      }
    }
    if (sepForce.mag() > 0) {
      sepForce.normalize();
      sepForce.mult(maxSpeed);
      sepForce.sub(speed);
      sepForce.limit(maxForce);
      return sepForce;
    } else {
      return new PVector(0, 0);
    }
  }

  PVector align(ArrayList<Boid> boids) {
    PVector aliForce = new PVector(0, 0);
    aliForce.add(speed);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(pos, other.pos);
      if ((d > 0) && (d < averageSpeedRange)) {
        aliForce.add(other.speed);
        count++;
      }
    }
    if (count > 0) {
      aliForce.div((float)count + 1.0);
      aliForce.mult(maxSpeed);
      aliForce.sub(speed);
      aliForce.limit(maxForce);
      return aliForce;
    } else {
      return new PVector(0, 0);
    }
  }

  PVector cohesion(ArrayList<Boid> boids) {
    PVector cohForce = new PVector(0, 0);
    cohForce.add(pos);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(pos, other.pos);
      if ((d > 0) && (d < averagePosRange)) {
        cohForce.add(other.pos);
        count++;
      }
    }
    if (count > 0) {
      cohForce.div((float)count + 1.0);
      return seek(cohForce);
    } else {
      return new PVector(0, 0);
    }
  }

  void render() {
    colorMode(HSB, 360, 100, 100);
    //float h = map(pos.x, 0, width, 0, 255);
    float hue = 260 + 150 * noise((millis()+pos.x * pos.y)/800.0);
    if(keyPressed) {
      if(key == 'p'){
        hue = 180 + 180 * noise((millis()+pos.x * pos.y)/600.0);
      } else if(key == 'b') {
        hue = 150 + 180 * noise((millis()+pos.x * pos.y)/600.0);
      } else {
        hue = 260 + 150 * noise((millis()+pos.x * pos.y)/800.0);
      }
    }
    float alpha = map(abs(pos.x-width/2), 0, width/2, 220, 60);
    noStroke();
    fill(hue, 92, 95, alpha);
    ellipse(pos.x, pos.y, 2.4, 2.4);
  }
}
