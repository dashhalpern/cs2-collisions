class hero{
  float ang;
  PVector vel;
  PVector cen;
  float recentshots;
  int status;
  int statuscount;
  hero(){
    cen = new PVector(width/2, height/2);
    ang = 0;
    vel = new PVector (0,0);
    status = 0;
  }
  //moves forward
  void up(){
    vel.add(cos(ang), sin(ang));
  }
  //turns counterclockwise
  void l(){
    ang = ang - .2;
  }    
  //turns clockwise
  void r(){
    ang = ang + .2;
  }
  // shoots breakers
  void down(){
    //checks to see how many breakers were shot recently
    if (recentshots < 2){
      breakers.add(new Breaker(cen.copy(), 20*cos(ang), 20*sin(ang)));
      //if status is 1 you ahve "shotgun" super power
      if (status == 1){
        breakers.add(new Breaker(cen.copy(), 20*cos(ang+.1), 20*sin(ang+.1)));
        breakers.add(new Breaker(cen.copy(), 20*cos(ang-.1), 20*sin(ang-.1))); 
      }
      recentshots++;
    }
  }
  //gives 'status' whitch is like a power helpign the hero
  void setpower(int p){
    //applys status
    status = p;
    statuscount = 150;
  }
  void render(){
    if(statuscount > 0){
    //decreases recentshots with time
      statuscount--;
    }
    else{
       status = 0;  
    }
    //decreases recentshots with time
    if (recentshots > 0){
      recentshots = recentshots - .05;
    }
    cen = new PVector((cen.x+width) % width , (cen.y+width) % width);
    cen.add(vel);
    /*comented out would apply drag
    PVector vs = vel.copy();
    if(mag(vs.x , vs.y) > .01){
      vs.normalize();
      vs.mult(.01);
    }
    vs.mult(-1);
    vel.add(vs);*/
    pushMatrix();
      translate(cen.x ,cen.y);
      rotate(ang);
      //changes color depending on status
      if(status == 1){
        fill(255, 0, 0);
      }else if(status == 2){
        fill(0, 0, 0, 100);
      }else{
        fill(255);
      }
      triangle(-2, -2, -2, 2, 4, 0);
    popMatrix();
  }
  PVector c(){
  //if status is 2 it returns fake PVector that will nto colide with anything
  if (status ==2){
   PVector fake = new PVector(-100, -100);
   return fake;
  }else{
   return cen;
  }
  }
}

/*  a hero class
will have a centerx and centery an angle(all floats)
forward left and right will change the angle and down will shoor breakers and it a 
collision test with asteroids and call void setup if they collide
you also need a function in breakers causing them to move and give it a pvector for
veloctiy and be removed if they are off the scren
*/