class soucer{
   PVector cen;
   PVector vel;
   int change = 0;
   int apear = 0;
   boolean isthere;
   soucer(){
     isthere = false;
     //cen is negative to avoid collisions
     cen = new PVector(-100, -100);
   }
  //makes the soucer apear with increasing probability everytiem it is called
  void apea(){
    //makes sure it isnt already drawn
    if (isthere == false){
      float chance = random (1, 2000);
      apear++;
      // checks to see if it will apear
      if(apear > chance){
        isthere = true;
        //whitch is a slightly random variable whitch stores where the soucer will come in
        int whitch = apear % 8;
        //gives random distance from the corner to start
        float varix = random(0, width / 2);
        float variy = random(0, height / 2);
        //draws possible starting points for the soucer and has it heading toward the center at 45 degrees
        if (whitch==0){
          cen = new PVector(0, variy);
          vel = new PVector(2, 2);
        }
        if (whitch==1){
          cen = new PVector(width, variy);
          vel = new PVector(-2, 2);
        }
        if (whitch==2){
          cen = new PVector(width, height-variy);
          vel = new PVector(-2, -2);
        }
        if (whitch==3){
          cen = new PVector(0, height-variy);
          vel = new PVector(2, -2);
        }        
        if (whitch==4){
          cen = new PVector(width-varix, height);
          vel = new PVector(-2, -2);
        }        
        if (whitch==5){
          cen = new PVector(varix, height);
          vel = new PVector(2, -2);
        }
        if (whitch==6){
          cen = new PVector(varix, 0);
          vel = new PVector(2, 2);
        }
        if (whitch==7){
          cen = new PVector(width-varix, 0);
          vel = new PVector(-2, 2);
        }
      }
    }
  }
  void update(){
    //makes sure it shoudl be drawn
    if (isthere == true){
      cen.add(vel);
      //counts up and has it change directions every 100 calls
      change++;
      if(change > 100){
        //randomly switches x and y half the time
        float plusminus = random(1);
        if (plusminus > .5){
          vel.x = vel.x*(-1);
        }
        plusminus = random(1);
        if (plusminus > .5){
          vel.y = vel.y*(-1);
        }
        change = 0;
      }
      //wraps around edge of screen
    cen = new PVector((cen.x+width) % width , (cen.y+width) % width);
    }
  }
  //draws soucer
  void render(){
    if (isthere == true){
      pushMatrix();
        fill(255, 0, 255);
        translate(cen.x ,cen.y);
        ellipse(0,0, 10, 10);
      popMatrix();
    }
  }
  //returns center
  PVector center(){
     return cen; 
  }
}