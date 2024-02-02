FlowField flowfield;
ArrayList<Particle> particles;

float flowFieldTimeStep = 0.000007;

void setup() {
  size(1200, 800);
  flowfield = new FlowField(20);
  flowfield.updateFF();
  initNParticles(10000);
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
    int r = (int) random(255);
    int g = (int) random(255);
    int b = (int) random(255);
    if(start_point.x < 300 || start_point.x > 900) {
      particles.add(new Particle(start_point, maxSpeed, r, g,b ));
    } else if(start_point.x < 500) {
      particles.add(new Particle(start_point, maxSpeed, 255, 255,255 ));
    }
    else if(start_point.x > 700 && start_point.x < 900) {
        particles.add(new Particle(start_point, maxSpeed, 0, 0, 0 ));
    } else {
          particles.add(new Particle(start_point, maxSpeed, 120,120, 120 ));

    }
  }
}
