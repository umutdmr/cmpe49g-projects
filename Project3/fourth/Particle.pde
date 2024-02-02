class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxForce = 0.1;
  float maxSpeed = 4;
  float r, g, b;

  Particle() {
    position = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    r = random(255);
    g = 0;
    b = 0;
  }

  void update() {
    int col = int(constrain(position.x / width * columns, 0, columns - 1));
    int row = int(constrain(position.y / height * rows, 0, rows - 1));
    float angle = flowField[col][row];
    PVector force = PVector.fromAngle(angle);
    force.mult(0.1);
    applyForce(force);
    updateEdges();
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
    r = (r + random(-5, 5)) % 256;
    g = (g + random(-5, 5)) % 256;
    b = (b + random(-5, 5)) % 256;
  }

 void applyFieldForce() {
    int col = int(constrain(position.x / width * columns, 0, columns - 1));
    int row = int(constrain(position.y / height * rows, 0, rows - 1));
    float angle = flowField[col][row];
    PVector force = PVector.fromAngle(angle);
    force.mult(0.1);
    applyForce(force);
    updateEdges();
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
    PVector diverge3 = new PVector(position.x - width/2,  position.y - height/2);
    if ((position.x - width/2) * (position.x - width/2) + (position.y - height/2)* (position.y - height/2) < 150000) {
      diverge3.setMag(10);
      applyForce(diverge3);
    }


  }
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void updateEdges() {
    if (position.x > width) position.x = 0;
    if (position.x < 0) position.x = width;
    if (position.y > height) position.y = 0;
    if (position.y < 0) position.y = height;
  }

  void display() {
    fill(r, g, b, 150);
    strokeWeight(0);
    ellipse(position.x, position.y, 8, 8);
  }
}
