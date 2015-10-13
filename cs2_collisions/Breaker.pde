class Breaker {
  PVector center;
  PVector vel;

  Breaker(PVector c) {
    center = c;
    vel = new PVector(0, 0); 
  }
  Breaker(PVector c, float vx, float vy){
     center = c; 
     vel = new PVector(vx, vy); 
  }

  // Create a Breaker with a random position, uniformly distributed
  // over the area of the window.
  Breaker() {
    center = new PVector(random(width), random(height));
  }
  
  float radius() {
    return 5;
  }
  void update() {
     center = center.add(vel); 
  }
  void render() {
    fill(255);
    stroke(0);
    ellipse(center.x, center.y, 5, 5);
  }
  PVector c(){
    return center;
  }
}