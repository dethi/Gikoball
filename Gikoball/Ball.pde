class Ball
{
  int x, y;
  float speedX, speedY;
  int WEIGHT = 50;
  int acceleration = 1;
  float COEFF_FROTTEMENT = 0.80;
  int nb_collisions = 0;
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
    for (int i = 0; i < 2; ++i)
    {
      if (is_ball_colliding_platform(platform_list[i].x, platform_list[i].y, 
      platform_list[i].platform_width, platform_list[i].platform_height))
      {
        ++nb_collisions;
        println("COLLISIONS N° "+nb_collisions);
        println("platform "+i+" x = " + platform_list[i].x + " y = "+ platform_list[i].y);
        println("ball x = "+this.x+" y = "+this.y);
      }
    }
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

  boolean is_ball_colliding_platform
    (int rectangle_x, int rectangle_y, int rectangle_width, int rectangle_height)  
  {
    rectangle_y = rectangle_y + rectangle_height;
    int circle_distance_x = abs(this.x - rectangle_x - rectangle_width / 2);
    int circle_distance_y = abs(this.y - rectangle_y - rectangle_height / 2);

    if (circle_distance_x > (rectangle_width / 2 + this.radius))
      return false;
    if (circle_distance_y > (rectangle_height / 2 + this.radius))
      return false;
    if (circle_distance_x <= (rectangle_width / 2))
      return true;
    if (circle_distance_y <= (rectangle_height / 2))
      return true;

    float corner_distance_sq = pow(circle_distance_x - rectangle_width / 2, 2) +
      pow(circle_distance_y - rectangle_height / 2, 2);

    return (corner_distance_sq <= pow(radius, 2));
  }
}

