class Ball
{
  int x, y;
  float speedX, speedY;
  int WEIGHT = 50;
  int acceleration = 1;
  float COEFF_FROTTEMENT = 0.80;
  
  // FUCKING RADIUS GUY !! BD
  int radius = 50;
  
  Ball(int x, int y)
  {
    this.x = x;
    this.y = y;
    speedX = 0;
    speedY = 0;
  }

  void keyPressed() 
  {
    if (key == CODED)
    {
      switch(keyCode) 
      {
      case LEFT:
        speedX += 1;
        break;
      case RIGHT:
        speedX -= 1;
        break;
      case DOWN:
        speedY -= 1.1;
        break;
      }
    }
  }

  void Gravity() {
    if (this.y >= 425)
    { //or change this to a method that gets the collision with the floor, set to screen height for now
      this.y = 424;
      speedY = -speedY * COEFF_FROTTEMENT; //no infinite bounce, the ball gradually slows down
    } else if (this.y <= 0)
    { //or change this to a method that gets the collision with the floor, set to screen height for now
      this.y = 1;
      speedY = -speedY * COEFF_FROTTEMENT; //no infinite bounce, the ball gradually slows down
    }
    if (this.x <= 0)
    { //or change this to a method that gets the collision with the floor, set to screen height for now
      this.x = 1;
      speedX = -speedX * COEFF_FROTTEMENT;
    } else if (this.x > 800)
    { //or change this to a method that gets the collision with the floor, set to screen height for now
      this.x = 799;
      speedX = -speedX * COEFF_FROTTEMENT;
    }

    speedY += (9.81 * WEIGHT / 1000);
    this.x -= speedX; 
    this.y += speedY;
  }

  void draw() 
  {
    Gravity();
    //need a sprite
    // MAKE ONE WITH PAINT, WESH ! BD
    ellipse(this.x, this.y, radius, radius);
  }
}

