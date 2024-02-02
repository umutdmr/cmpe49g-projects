FlowField flowfield;
ArrayList<Particle> particles;

float flowFieldTimeStep = 0.000007;

void setup() {
  size(1200, 800);
  flowfield = new FlowField(20);
  flowfield.updateFF();
  initNParticles(100000);
}

void draw() {
  flowfield.updateFF();  
  for (Particle p : particles) {
    p.applyFieldForce(flowfield);
    p.run();
  }
}
void initNParticles(int n){
  particles = new ArrayList<Particle>();
  for (int i = 0; i < n; i++) {
    float maxSpeed =random(0, 1);
    PVector start_point = new PVector(random(width), random(height));
    int r = 0;
    int g = 0;
    int b = 1;
    float factor = start_point.x / 6;
    particles.add(new Particle(start_point, maxSpeed, r,g, (int)b * (int)factor));
  }
}
