public class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector previousPos;
  float maxSpeed;
  int r, g, b;

  Particle(PVector start, float maxspeed, int pr, int pg, int pb) {
    maxSpeed = maxspeed;
    pos = start;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    previousPos = pos.copy();
    r = pr;
    g = pg;
    b = pb;
  }

  void run() {
    updatePosition();
    edges();
    show();
  }

  void updatePosition() {
    pos.add(vel);
    vel.add(acc);
    vel.limit(maxSpeed);
    acc.mult(0);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void applyFieldForce(FlowField flowfield) {
    int x = floor(pos.x / flowfield.scale);
    int y = floor(pos.y / flowfield.scale);

    PVector force = flowfield.vectors[x][y];
    applyForce(force);

    PVector diverge1 = new PVector(pos.x - width/3,  pos.y - height/3);
    PVector diverge2 = new PVector(pos.x - 2*width/3,  pos.y - 2*height/3);
    PVector diverge3 = new PVector(pos.x - width/2,  pos.y - height/2);
    if ((pos.x - width/3) * (pos.x - width/3) + (pos.y - height/3)* (pos.y - height/3) < 10000) {
      diverge1.setMag(10);
      applyForce(diverge1);
    }
    if ((pos.x - 2*width/3) * (pos.x - 2*width/3) + (pos.y - 2*height/3)* (pos.y - 2*height/3) < 10000) {
      diverge2.setMag(10);
      applyForce(diverge2);
    }
    if ((pos.x - width/2) * (pos.x - width/2) + (pos.y - height/2)* (pos.y - height/2) < 10000) {
      diverge3.setMag(10);
      applyForce(diverge3);
    }


  }

  void show() {

    stroke(r, g, b, 45);
    strokeWeight(2);
    strokeCap(SQUARE);
    line(pos.x, pos.y, previousPos.x, previousPos.y);
    updatePreviousPos();

  }

  void updatePreviousPos() {
    this.previousPos.x = pos.x;
    this.previousPos.y = pos.y;
  }

  void edges() {
    if (pos.x > width) {
      pos.x = 0;
      updatePreviousPos();
    }
    if (pos.x < 0) {
      pos.x = width;  
      updatePreviousPos();
    }
    if (pos.y > height) {
      pos.y = 0;
      updatePreviousPos();
    }
    if (pos.y < 0) {
      pos.y = height;
      updatePreviousPos();
    }
  }

}
