// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float noiseOffset;
  float noiseScale;

  Particle(PVector l) {
    noiseOffset = 10000;
    noiseScale = 0.15;
    acceleration = new PVector(0.0, 0.0);
    velocity = new PVector(0.0, 0.0);
    position = l.copy();
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    acceleration.set(pNoise(position.x, position.y, millis()) , pNoise(position.x, position.y, millis() + noiseOffset));
    velocity.add(acceleration);
    
    velocity.limit(2);
    
    float x = position.x + velocity.x; 
    float y = position.y + velocity.y;
    
    if (position.x + velocity.x < 0)
      x = width + (position.x + velocity.x);
    if (position.x + velocity.x > width)
      x = 0 + (width - (position.x + velocity.x));
    if (position.y + velocity.y < 0)
      y = height + (position.y + velocity.y);
    if (position.y + velocity.y > height)
      y = 0 + (height - (position.y + velocity.y));
 
    position.set(x, y);  //<>//
  }

  // Method to display
  void display() {
    stroke(255);
    fill(255);
    ellipse(position.x, position.y, 10, 10);
  }
  
  float pNoise(float x, float y, float z) {
    return (noise((x / 500), (y / 500), (z / 500)) - 0.5) * noiseScale;
  }               
}
