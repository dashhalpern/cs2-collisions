import java.util.HashSet;
int scr;
int pow;
int powcount;
// Detect collisions between Breakers and Asteroids.  Remove the
// Asteroids involved in collisions, and replace them with smaller
// Asteroids.  Remove Breakers involved in collisions.
void handleCollisions() {
     // Asteroids which collided this timestep
  HashSet<Asteroid> collisions = new HashSet();

  // Breakers which collided this timestep.
  HashSet<Breaker> usedBreakers = new HashSet();

  // Keep track of which objects collided.  Don't delete them inside
  // the loop, because that messes up the Iterator.
  for (Breaker b : breakers) {
    for (Asteroid a : asteroids) {
      if (colliding(a, b)) {
        collisions.add(a);
        usedBreakers.add(b);
      }
    }
  }
 scr = scr + collisions.size();
  // Split or remove the Asteroids which collided
  for (Asteroid a : collisions) {
    asteroids.remove(a);
       if (a.canSplit()) {
         children = a.children();
         asteroids.add(children.a);
         asteroids.add(children.b);
       }
  }
  
  // Remove the Breakers which collided
  for (Breaker b : usedBreakers) {
    breakers.remove(b);
  }
}

// The number of (random) elements to create.
int initialAsteroids = 1;
int initialBreakers = 0;

ArrayList<Asteroid> asteroids = new ArrayList();
ArrayList<Breaker> breakers = new ArrayList();

// Store time (ms) of last update.
float t, last_t, dt;
Pair<Asteroid, Asteroid> children;
hero h;
boolean die;
void setup() {
  begin();
  size(1000,1000);
}
void begin(){
  h = new hero();
  // Make random Asteroids
  asteroids = new ArrayList();
  int i = 0;
  while(i < initialAsteroids) {
    asteroids.add(new Asteroid());
    i++;
  }
  // Randomly place Breakers
  i = 0;
  while(i < initialBreakers) {
    breakers.add(new Breaker());
    i++;
  }
  die = false;
}

void draw() {
  //displays score
  String scrb = str(scr);
  clear();
  background(255, 204, 0);
  fill(255);
  text(scrb ,10,100);
  
  //displays power if any
  if(powcount > 0){
    powcount--;
    println("pow:");
    println(pow);
    if(pow == 1){
      println("here");
      String power = "shotgun";
      text(power, 10, 130); 
    }else if(pow == 2){ 
      String power = "invincible"; 
      text(power, 10, 130);
    }
  }
  // Render all the Asteroids
  for(Asteroid a : asteroids) {
    a.render();
  }

  // Render all the Breakers
  for(Breaker b : breakers) {
    b.update();
    b.render();
  }

  // Update the positions of the Asteroids
  t = millis();
  dt = last_t - t;
  last_t = t;
  
  //deals with asteroid hitting shit 
  for(Asteroid a : asteroids) {
    a.update(dt);
    if (hith(a)){
      die = true;
    }
  }
  if (die){
     initialAsteroids = 1;
     scr = 0;
     begin(); 
  }
  
  handleCollisions();

  h.render();
  
  //starts new level if all asteroid are destroyed
  int na = asteroids.size();
  if (na == 0){
    initialAsteroids++;
    begin(); 
  }
}
//checks asteroid breaker collision
boolean colliding(Asteroid ac, Breaker bc){
  PVector acc = ac.c();
  PVector bcc = bc.c();  
  float acr = ac.radius();
  float dis = acc.dist(bcc);
  if (dis < acr + 5){
    return true;
  }
  else{
    return false;
  }
}


void distance(PVector ast1, PVector ast2){
  float xdis = ast1.x - ast2.x;    
  float ydis = ast1.y - ast2.y;
  float dis = sqrt(sq(ydis)+sq(xdis));
}


void keyPressed() {
    if (keyCode == UP){
      h.up();
    }
    if (keyCode == LEFT){
      h.l();
    }    
    if (keyCode == RIGHT){
      h.r();
    }
    if (keyCode == DOWN){
      h.down();
    }    
    //allows player to sacrifice score to apply a power at random
    if (keyCode == CONTROL){
      if(scr >= initialAsteroids*10){
        scr = scr - 10*initialAsteroids;
        pow = int(random(1,3));
        h.setpower(pow);
        powcount = 150;
      }
    }
}

//checks asteroid hero collision
boolean hith(Asteroid ac){
 PVector acc = ac.c();
 PVector bcc = h.c();  
 float acr = ac.radius();
 float dis = acc.dist(bcc);
 if (dis < acr + 1){
   return true;
  }
  else{
    return false;
  }
}
