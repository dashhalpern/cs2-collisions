class Asteroid {
     final int size;  // number of sides
     PVector center;  // position of center, in screen coordinates
     final PVector v;  // velocity, per second, in screen coordinates
     int radius;
  Asteroid(int s, PVector c, PVector v_) {
    size = s;
    center = c;
    v = v_;
  }
  
  // Create a new Asteroid with a random position & velocity.  The
  // position is uniformly distributed over the window area.  The
  // velocity is in a random direction, always with magnitude 100
  // pixels/second.
  Asteroid() {
    size = 7;
    center = new PVector(random(width), random(height));
    v = new PVector(200,0);
    v.rotate(random(TWO_PI));
  } 

  // Update the position of the Asteroid according to its velocity.
  // The argument dt is the elapsed time in milliseconds since the
  // last update.  Modifies the Asteroid.
  public void update(float dt) {
    PVector dv = v.copy();
    dv.mult(dt/1000);
    center.add(dv);
    center.x = (center.x+width) % width;
    center.y = (center.y+height) % height;
  }
  int childShape(){
    return size-1;
  }
  boolean canSplit(){
   if (size > 4){
     return true;
   }else{
     return false; 
   }
  }
  float radius(){
    return 2*(pow((1.27),(size-4))*10);
  }
  // Draw a polygon with the current style.  `polygon(x, y, r, n)
  // draws a n-sided polygon with its circumcenter at (x,y), with a
  // distance r from the center to each vertex.
  private void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
  }
  void render(){
    fill(255);
    polygon(center.x, center.y, this.radius(), size);
  }
  PVector c(){
    return center;
  }
  float radi(){
    return radius; 
  }
  //returns 2 velocities for children 
  Pair<PVector, PVector> childVelocity(){
    v.mult(1.1);
    PVector as1 = v;
    PVector as2 = v.copy();
    as1.rotate(radians(30));
    as2.rotate(radians(-30));
    Pair<PVector, PVector> childV = new Pair(as1, as2);
    return(childV);
  }
  //returns and creates two child astroids
  Pair<Asteroid, Asteroid> children(){
    int sizec = childShape();
    Pair<PVector, PVector> velc = this.childVelocity();
    Asteroid astc1 = new Asteroid(sizec, center.copy(),  velc.a); 
    Asteroid astc2 = new Asteroid(sizec, center,  velc.b); 
    Pair<Asteroid, Asteroid> child = new Pair(astc1, astc2);
    return child;
  }
}