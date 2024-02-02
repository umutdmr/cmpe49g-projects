int columns = 20;
int rows = 20;
float[][] flowField;

ArrayList<Particle> particles;

void setup() {
  background(0);
  size(1200, 800);
  flowField = new float[columns][rows];
  initNParticles(50);
}

void initNParticles(int n){
  particles = new ArrayList<Particle>();
  for (int i = 0; i < n; i++) {
    particles.add(new Particle());
  }
}
void draw() {
  updateFlowField();
  updateParticles();
}

void updateFlowField() {
  float x_offset = 0;
  for (int i = 0; i < columns; i++) {
    float y_offset = 0;
    for (int j = 0; j < rows; j++) {
      float angle = noise(x_offset, y_offset) * TWO_PI * 4;
      PVector v = PVector.fromAngle(angle);
      flowField[i][j] = angle;
      y_offset += 0.1;
      stroke(0, 50);
      pushMatrix();
      translate(i * width / columns, j * height / rows);
      rotate(v.heading());
      line(0, 0, width / columns, 0);
      popMatrix();
    }
    x_offset += 0.1;
  }
}

void updateParticles() {
  for (Particle p : particles) {
    p.update();
    p.display();
  }
}
