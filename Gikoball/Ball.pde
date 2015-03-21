class Ball
{
  float x, y;
  float speedX, speedY;
  int WEIGHT = 50;
  int acceleration = 1;
  float COEFF_FROTTEMENT = 0.80;
  int nb_collisions = 0;
  float radius = 50;
  int t = 0;
  float gravityPower = 0.97;

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
      switch(keyCode)//todo, change this switch (you should be able to move + accelerate in same time)
      {
      case LEFT:
        speedX += 0.5;
        break;
      case RIGHT:
        speedX -= 0.5;
        break;
      case DOWN:
        speedY += 0.5;
        break;
      }
    }
  }

  void Gravity() {
    if (this.y >= 425)
    { //or change this to a method that gets the collision with the floor, set to screen height for now
      this.y = 424;
      speedY = -speedY /** COEFF_FROTTEMENT*/; //no infinite bounce, the ball gradually slows down
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

    t++;
    if (t==5)
    {
      speedY = speedY * gravityPower;
      t = 0;
    }

    speedY += (9.81 * WEIGHT / 1000);

    speedX = speedX * 0.97;
    this.x -= speedX; 
    this.y += speedY;
  }

  void draw() 
  {
    Gravity();
    //todo, need a sprite, add an animated sprite!
    // MAKE ONE WITH PAINT, WESH ! BD
    ellipse(this.x, this.y, radius, radius);
  }

  /* params:
   circleX - center x coordinate for circle
   circleY - center y coordinate for circle
   radius  - radius of circle
   rectangleX - top left corner X coordinate
   rectangleY - top left corner Y coordinate
   rectangleWidth - width of rectangle
   rectangleHeight - and the height
   */

  boolean isCollidingCircleRectangle(
  float circleX, 
  float circleY, 
  float radius, 
  float rectangleX, 
  float rectangleY, 
  float rectangleWidth, 
  float rectangleHeight)
  {
    float circleDistanceX = abs(circleX - rectangleX - rectangleWidth/2);
    float circleDistanceY = abs(circleY - rectangleY - rectangleHeight/2);

    if (circleDistanceX > (rectangleWidth/2 + radius)) { 
      return false;
    }
    if (circleDistanceY > (rectangleHeight/2 + radius)) { 
      return false;
    }

    if (circleDistanceX <= (rectangleWidth/2)) { 
      return true;
    }
    if (circleDistanceY <= (rectangleHeight/2)) { 
      return true;
    }

    float cornerDistance_sq = pow(circleDistanceX - rectangleWidth/2, 2) +
      pow(circleDistanceY - rectangleHeight/2, 2);

    return (cornerDistance_sq <= pow(radius, 2));
  }
}

